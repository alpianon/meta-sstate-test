SSTATE_TEST_DIR = "${TMPDIR}/sstate-test/${PN}"
SSTATE_TEST_FILE = "${SSTATE_TEST_DIR}/sstate-test.json"

python do_sstatetest () {
    bb.warn("writing to %s" % d.getVar("SSTATE_TEST_FILE"))
    with open(d.getVar("SSTATE_TEST_FILE"), "w") as f:
        f.write("Hello World!")
}

addtask do_sstatetest after do_unpack before do_patch

SSTATETASKS += "do_sstatetest"
do_sstatetest[sstate-plaindirs] = "${SSTATE_TEST_DIR}"

python do_sstatetest_setscene () {
    sstate_setscene(d)
}

addtask do_sstatetest_setscene

do_sstatetest[dirs] = "${SSTATE_TEST_DIR}"
