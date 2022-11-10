Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA8624589
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Nov 2022 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiKJPWJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Nov 2022 10:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKJPWI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Nov 2022 10:22:08 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D010B4F;
        Thu, 10 Nov 2022 07:22:05 -0800 (PST)
Received: from letrec.thunk.org ([12.139.153.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AAFLswW006672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 10:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668093717; bh=YwdNhjsE3SJmg5CT/VWQ/NICaXgoIELaYhai8lEHU/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dSv/nfNBBhHgCYAO8XyaNXOdS5AkjC6/TPY7Vh3lTpL1ynNjqMGByChVMkGJ9fHeu
         P4bBrDHWiXvLVwccwqeKDEyV1kUOdu7RH3Ujejw+8zZOdYK/vJT7DqPnDUXn1GREiw
         AC3mPJ7horsy5EP6FNI8GzENxSV9TonwPkNqPOdotIEKgt33R1w+13Au8FHEUX9Usx
         Di6uSSZTZ0U2v9srCl9eAire3ffmkSTxoeXbDSWJSIK7zUF7L3UvEmrjBwPEGngH3g
         gksgGY3wvVDv7Ei6MS34EXc/po+wTCAKYM1JXdgO8oORLpjLKzDcsLfp1ioNmiLKE6
         j6ojCnYks4y/Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9A1E88C0255; Thu, 10 Nov 2022 10:21:55 -0500 (EST)
Date:   Thu, 10 Nov 2022 10:21:55 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Message-ID: <Y20XE0t0O632MI3k@mit.edu>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
 <20221109041951.wlgxac3buutvettq@shindev>
 <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
 <Y2vsJc1CKuUNzGID@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2vsJc1CKuUNzGID@magnolia>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 09, 2022 at 10:06:29AM -0800, Darrick J. Wong wrote:
> I've been testing with xfs/btrfs/ext4 nightly, and haven't seen any
> problems with the last two.  There's some very infrequent log accounting
> problem that is probably a regression from Dave's recent round of log
> refactorings, so once we're clear of the write race corruption problem,
> I intend to inquire about that.
> 
> Granted I also don't have hundreds-of-cpus machines to test this kind of
> stuff, so I don't know how well hotplug mania fares on a big iron.
> 
> I don't think it's valid to remove a test from the auto group because it
> uncovers bugs.  If test runner folks want to put it in their own exclude
> lists for their own convenience, that's fine with me.

Well, for me, on a GCE VM (but not using KVM), using ***any*** file
system, the test is an automatic instant crash of the VM.  It's a
pretty clearly a CPU hotplug bug, not a file system bug.  And given
that the purpose of running the test is to find file system bugs, and
running the test prevents the rest of the file system tests from
running, of course it's on my exclude list for gce-xfstests.

I don't care *that* much whether it's removed from the auto group or
not, or added to the dangerous group or not, but perhaps we should add
a comment that this may trigger unrelated bugs in CPU hotplug, so that
other testers don't run into this?

I'm also especially thinking about "drive-by testers", who might not
be tracking the fstests mailing list and won't know the nuances of "oh
yeah, you need to add this to the exclude list, or you may be
sorry....".  On the other hand, that's why I recommend that drive-by
testers use things like my test runner infrastructure, and not
xfstesets directly.  :-)

						- Ted
