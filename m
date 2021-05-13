Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFC37FA3B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhEMPEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 11:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234757AbhEMPEH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 11:04:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3637361439;
        Thu, 13 May 2021 15:02:57 +0000 (UTC)
Date:   Thu, 13 May 2021 11:02:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210513110255.1e694116@gandalf.local.home>
In-Reply-To: <F1912581-EA58-442C-86AD-717E138CE47B@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
        <20210512122623.79ee0dda@gandalf.local.home>
        <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
        <20210513105018.7539996a@gandalf.local.home>
        <F1912581-EA58-442C-86AD-717E138CE47B@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 13 May 2021 14:53:35 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > Something like this?  
> 
> That looks about right!
> 
> With the caveat that a non-NUL-terminated string might contain a NUL.
> When displayed with '%s', such a string would be truncated.

Right, but that would be the case even with %.*s. So it works the same.

-- Steve
