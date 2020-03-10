Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BA417FD7C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 14:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgCJN1P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 09:27:15 -0400
Received: from mailomta18-re.btinternet.com ([213.120.69.111]:48450 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727442AbgCJN1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 09:27:09 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20200310132706.EAKG21762.re-prd-fep-047.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 10 Mar 2020 13:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583846826; 
        bh=Vr1M4kogaTaPGZLL6wCdrk/HvDlNqOFVoHqrzWZ7vMA=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=opA9jHn9dfm7/72is2n+cxRuSCeDgr2Pjjoxn3XFHXmg0OWE937fYiMAH41hK7HHLxHQ00CybfNFur3fgfEaISfE4k7RRRZMp/P3qNSiXvuxrjP7Ctd0LFVEBoTcONmH/2rZLIu5zkjR45CrS6DOPJpk2mn0hoCkF16WB7iE2rn+Yw0UeVWiZtLsuJ50A2eDt1xILZfqS5ZbD4UWNC5eLX6LTrK9KYPV1iwmFjTcJDC2y28CP3iafO4O8QO29xhLpIKcKhPJpmKIUlFR78FD9AlXq7iBT4a4m745IhYDjKvOTPXoEDkq97qSDxBFzHKOYu3t8OQG8iWFp/OIlFUA7g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.57.243]
X-OWM-Source-IP: 31.49.57.243 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeefuddrgeelrdehjedrvdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheejrddvgeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorghnnhgrrdhstghhuhhmrghkvghrsehnvghtrghpphdrtghomheqpdhrtghpthhtohepoegsfhhivghlughssehfihgvlhgushgvshdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghi
        nhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsmhgrhihhvgifsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheqpdhrtghpthhtohepoehtrhhonhgurdhmhihklhgvsghushhtsehhrghmmhgvrhhsphgrtggvrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.57.243) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A147D053FEBF9; Tue, 10 Mar 2020 13:27:06 +0000
Message-ID: <46f9ffe8fa54538951dacac478c08077a744c8d7.camel@btinternet.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Date:   Tue, 10 Mar 2020 13:27:04 +0000
In-Reply-To: <CAEjxPJ6pLLGQ2ywfjkanDNZc1isVV8=6sJmoYFy8shaSGr972A@mail.gmail.com>
References: <20200303225837.1557210-1-smayhew@redhat.com>
         <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
         <20200304143701.GB3175@aion.usersys.redhat.com>
         <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
         <20200306220132.GD3175@aion.usersys.redhat.com>
         <dc704637496883ac7c21c196aeae4e1ab37f76fa.camel@btinternet.com>
         <CAEjxPJ6pLLGQ2ywfjkanDNZc1isVV8=6sJmoYFy8shaSGr972A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-03-09 at 09:35 -0400, Stephen Smalley wrote:
> On Sun, Mar 8, 2020 at 1:47 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Fri, 2020-03-06 at 17:01 -0500, Scott Mayhew wrote:
> > > On Wed, 04 Mar 2020, Stephen Smalley wrote:
> > > > I should note that we are getting similar errors though when
> > > > trying
> > > > to
> > > > specify any context-related
> > > > mount options on NFS via the new fsconfig(2) system call, see
> > > > https://github.com/SELinuxProject/selinux-kernel/issues/49
> > I've done further testing and found that with this patch the
> > fsconfig(2) problem is also resolved for nfs (provided the
> > rootcontext
> > is not specified).
> 
> Excellent, two bugs fixed with one patch!
> 
> > > > It still needs some further
> > > > enhancements as per
> > > > https://github.com/SELinuxProject/selinux-testsuite/issues/32#issuecomment-582992492
> > > > but it at least provides some degree of regression testing.
> > Could you describe how I could test these, also are there any other
> > SELinux tests that may be useful (with howto's). I'm almost ready
> > to
> > post another set of RFC test patches, but can add more.
> 
> The ones identified in that github issue comment would simply be
> additional tests in tools/nfs.sh
> unless they happen to already be covered by your fs/filesystem tests
> once those are applied to the
> host/native filesystem instead of just ext4.  The test cases are:
> 
> 0. Test the bug fixed by this patch, i.e. perform mount of a
> security_label exported filesystem, check the label of the mounted
> directory to confirm it isn't unlabeled.
> That's a NFS-specific test, goes in tools/nfs.sh.
> 
> 1. Mount the same filesystem twice with two different sets of context
> mount options, check that mount(2) fails with errno EINVAL.
> Test cases might include a) mount first without any context mount
> options, then try mounting a 2nd time with context mount options and
> vice versa, b) mounting
> with the same set of context options (e.g. both using context=) but
> different context values, c) mounting with different sets of context
> options (e.g. one uses
> context=, the other uses fscontext=).  This test could be done in
> fs/filesystem for any filesystem type, not NFS-specific.
> 
> 2. Mount a security_label exported NFS filesystem twice, confirm that
> NFS security labeling support isn't silently disabled by trying to
> set a label on a file and confirm it is set (fixed by  kernel commit
> 3815a245b50124f0865415dcb606a034e97494d4).  This would go in
> tools/nfs.sh
> since it is NFS-specific.

And another one. If you run the same mount twice using mount(2) you get
EBUSY. If you run with fsmount(2) it works. A simple test below, just
set $1 to fs for fsmount(2)

Otherwise I've completed the remaining tests with no problems.

#!/bin/sh -e
MOUNT=`stat --print %m .`
TESTDIR=`pwd`
NET="nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1"

function err_exit() {
    echo "Error on line: $1 - Closing down NFS"
    umount /mnt/selinux-testsuite
    exportfs -u localhost:$MOUNT
    rmdir /mnt/selinux-testsuite
    systemctl stop nfs-server
    exit 1
}

trap 'err_exit $LINENO' ERR

systemctl start nfs-server
exportfs -orw,no_root_squash,security_label localhost:$MOUNT
mkdir -p /mnt/selinux-testsuite

if [ $1 ] && [ $1 = 'fs' ]; then
    RUN="tests/fs_filesystem/fsmount"
else
    RUN="tests/filesystem/mount"
fi

$RUN -v -f nfs -o vers=4.2,$NET,context=system_u:object_r:etc_t:s0 -s
localhost:$TESTDIR -t /mnt/selinux-testsuite
$RUN -v -f nfs -o vers=4.2,$NET,context=system_u:object_r:etc_t:s0 -s
localhost:$TESTDIR -t /mnt/selinux-testsuite
echo "Testing context mount of a security_label export."
fctx=`secon -t -f /mnt/selinux-testsuite`
if [ "$fctx" != "etc_t" ]; then
    echo "Context mount failed: got $fctx instead of etc_t."
    err_exit $LINENO
fi
umount /mnt/selinux-testsuite
umount /mnt/selinux-testsuite

echo "Done"
exportfs -u localhost:$MOUNT
rmdir /mnt/selinux-testsuite
systemctl stop nfs-server


> 
> 3. Perform a context= mount of a security_label exported NFS
> filesystem, check that pre-existing files within the mount show up
> with the context= value
> not the underlying xattr value (fixed by kernel commit
> 0b4d3452b8b4a5309b4445b900e3cec022cca95a). My original version of
> tools/nfs.sh actually would have caught this because it was testing
> the context of the nfs.sh script file itself within the context mount
> but I dropped it back to only checking the top-level mount directory
> when I moved tools/nfs.sh to avoid depending on a fixed location for
> it, so it won't be caught currently. We could just change it back to
> testing the context of a pre-existing file within the mount; any file
> will do.  This would go in tools/nfs.sh, NFS-specific.
> 
> 4. Ensuring that all of the tests/filesystem and tests/fs_filesystem
> tests that make sense for NFS are being run on the labeled NFS mount
> itself when run via tools/nfs.sh and not just on an ext4 mount
> created
> by the test script.

