Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB106143314
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 21:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgATUwl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jan 2020 15:52:41 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45931 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgATUwl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jan 2020 15:52:41 -0500
Received: by mail-pg1-f172.google.com with SMTP id b9so234841pgk.12
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2020 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:organization
         :mime-version:date:user-agent:content-transfer-encoding;
        bh=oT/PEKHTDAEu4Wui9vP14UawSG7Ju8CU4hlVQn4lc1o=;
        b=Wz8jTlNEafex2bJJrdN/eZ+AajqrUlo6ohnviz7TX8kqn7QFZiija4Nbu1gBIkApy8
         GHvTHsKWJVbWRQhNHLYsg3e4ic7HOtnYY2MXyy1WKL2wNV4oWwhKjKTd8NO2qY1NgnTC
         sDMAtByusflI3kkNRoRGTv3TTOfyPcep2SUKBQq+PcCJy9/6ME6qMlPjkrgtdFX4tgxp
         xWmCs0JmOF2T05EzVonhR4D57OV4dHNCaJw52ShUbZ7u2XNVIyyzeotYOqZ06sROz3rQ
         f59pxJ7uO1YeFFsLK8idEV9KsldHwfKSEZTPnj1aVvvOaKkXGnPnxFhBZnDSA78bbzab
         mu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:organization:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=oT/PEKHTDAEu4Wui9vP14UawSG7Ju8CU4hlVQn4lc1o=;
        b=WJwLE/beylwXTnUgz5H4CT1wEh2p0xEID+UEtxD4uJDuKmTfeGKilSv2z4LLEX9bYK
         d1knTiL2WQsyv/MXNX80omASJt/vabYQKl6p0DOJuIcXKXszqz6c7qJUhfcvuHEkeaJd
         5RCstChhjw9WhrycaVeR9a0U387Y2guEavGfQx4Cx6guZFzlbq3wFiE09t57w59YEFJk
         oDCNE7MTf2nUfzK2QL25kL2Fq9YQ0CvTBBJsy489O9Qm5kfDqPNeDO8D8MFMbjWkhYmm
         Xocvm0TlNDLyuyY/XsDlEJO4RjVNN3jnoHVaPUNhqBHoRBTozb8RbX5WV8Hf9GV+D7e9
         EGrA==
X-Gm-Message-State: APjAAAVGoUTUWfzoL632bwZxvnK6n0dWvy62Vo4UVOJ9aSAKF9TA/jhh
        Yyg+QESBOK6ce370+sSt4A==
X-Google-Smtp-Source: APXvYqy2npV2Lzsdw8p4hhzNp+FbCrfOzHS6d8ttkHvZNaV+I/t+dhP9ONzQoX2bTnb8zlnZxtMgnQ==
X-Received: by 2002:a63:8c48:: with SMTP id q8mr1623390pgn.213.1579553560383;
        Mon, 20 Jan 2020 12:52:40 -0800 (PST)
Received: from leira (63-235-104-78.dia.static.qwest.net. [63.235.104.78])
        by smtp.gmail.com with ESMTPSA id c17sm39575851pfi.104.2020.01.20.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 12:52:39 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <388ff8a1abebdf0eab8e696cb09148c0704dd766.camel@hammerspace.com>
Subject: Re: 'ls -lrt' performance issue on large dir while dir is being
 modified
To:     Dai Ngo <dai.ngo@oracle.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
In-Reply-To: <52079beb-1f27-35d8-c92a-6a6b430c7c8f@oracle.com>
References: <e04baa28-2460-4ced-e387-618ea32d827c@oracle.com>
         <a41af3d6-8280-e315-fb65-a9285bad50ec@oracle.com>
         <770937d3-9439-db4a-1f6e-59a59f2c08b9@oracle.com>
         <9fdf37ffe4b3f7016a60e3a61c2087a825348b28.camel@hammerspace.com>
         <49bfa6104b6a65311594efd47592b5c2b25d905a.camel@hammerspace.com>
         <8439e738-6c90-29d9-efc8-300420b096b1@oracle.com>
         <43fae563e93052f9dc9584ddd800770a7b3b10d2.camel@hammerspace.com>
         <9327BCC2-6B75-47E3-8056-30499E090E18@oracle.com>
         <3456dea05ac1a2d82c077146e8638130e313edca.camel@hammerspace.com>
         <52079beb-1f27-35d8-c92a-6a6b430c7c8f@oracle.com>
Organization: Hammerspace Inc
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 20 Jan 2020 12:52:13 -0800
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2020-01-18 at 10:03 -0800, Dai Ngo wrote:
> 
> I think this is the contention point: the spec did not explicitly
> mention anything regarding mixing of cookies from READDIR &
> READDIRPLUS.
> 
> However, as I mentioned, the current client implementation already
> mixing
> cookies between READDIRPLUS and READDIR, everytime the user does a
> simple
> 'ls' on a large directory, without invalidating any mapping.
> 
> Also, as Chuck mentioned, we're not aware of any server
> implementation
> that has problems with this mixing of cookies.
> 

OK I did a little time warp and went back to the original emails around
this behaviour:

https://linux-nfs.vger.kernel.narkive.com/O0Xhnqxe/readdir-vs-getattr


Part of the problem that needed solving at the time was that even when
the directory and its contents were not changing, people were still
needing to do reams of GETATTR calls in order to typically satisfy an
'ls -l' or even 'ls --color'. When we see that pattern, we want to
switch from using GETATTR on all these files to using READDIRPLUS.

The cache invalidation was introduced in order to force the NFS client
to do these READDIRPLUS calls so we avoid the GETATTRs.

So one optimisation we could definitely do is try to track the index of
the last page our descriptor accessed on readdir(), and truncate only
the remaining pages. That way we don't keep re-reading the beginning of
the directory.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



