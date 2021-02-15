Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9178231C2E2
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 21:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBOUPu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 15:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBOUPu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Feb 2021 15:15:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF40464DDA;
        Mon, 15 Feb 2021 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613420110;
        bh=xoVG1a3XwJKuGPZNDgpZio79voqPVD3cw0d8BZupMYU=;
        h=Subject:From:To:Cc:Date:From;
        b=SDtxFmNiwMydvYVRZhXov0IEEDjJvqRxOZ4wdRxMTzzX2nhRdrDiB3iuMmM3l5ruZ
         HgHxLS7sQp579lwv89vK5MwozM8BejmTquE6CAGtVfklotPtEtucMhRPoZW/i5g5yr
         bYDoWei4qy914eTlbSUC2vDDtAvj82BMYQeRaeii2uqMTBlSgLg5OjJtWOvTrhCVwb
         khKujVVdWFqCOjCgHHg1gtacKfVJ28QW3MAIhvI0fL5ogUefv2cBVkNKFAmwpaRMH+
         Qpp5NISLRoncb4x5Uvd+1WzoHKeHJSJ0a4Jab/QPpffsOAqi4woHF8uU9r0owk7kNv
         ovq8KObouvb/w==
Message-ID: <804830ba7fdd91cbf9348050b07f9922801d20f0.camel@kernel.org>
Subject: pynfs breakage
From:   Jeff Layton <jlayton@kernel.org>
To:     Bruce Fields <bfields@fieldses.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
Date:   Mon, 15 Feb 2021 15:15:08 -0500
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce!

The latest HEAD in pynfs doesn't run for me:

$ ./nfs4.1/testserver.py --help
Traceback (most recent call last):
  File "/home/jlayton/git/pynfs/nfs4.1/./testserver.py", line 38, in <module>
    import server41tests.environment as environment
  File "/home/jlayton/git/pynfs/nfs4.1/server41tests/environment.py", line 593
    def write_file(sess, file, data, offset=0 stateid=stateid4(0, b''),
                                              ^
SyntaxError: invalid syntax

If I revert this commit, then it works:

commit 49ae5ba83dd98936b3f5c24431a166866b70f34a (HEAD -> master, origin/master, origin/HEAD)
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Thu Feb 11 16:22:58 2021 -0500

    nfs41: read_file and write_file helpers
    
    A couple simple helpers copied from 4.0.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>


Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

