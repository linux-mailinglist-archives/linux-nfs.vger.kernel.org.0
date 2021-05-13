Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824AE37FDB8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 21:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhEMTCA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 15:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhEMTB7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 15:01:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A049C613B5;
        Thu, 13 May 2021 19:00:48 +0000 (UTC)
Date:   Thu, 13 May 2021 15:00:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210513150047.6b8ed9fb@gandalf.local.home>
In-Reply-To: <107A51EE-E0A8-46FE-9E62-9FC586B91F19@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
        <20210512122623.79ee0dda@gandalf.local.home>
        <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
        <20210513105018.7539996a@gandalf.local.home>
        <C3D7DA41-C5B1-4388-B55C-E8A1280E9C9E@oracle.com>
        <107A51EE-E0A8-46FE-9E62-9FC586B91F19@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 13 May 2021 18:43:29 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> >> Would something like that work?  
> > 
> > I will test later today and let you know in this thread.  
> 
> All good.
> 
> Tested-by: Chuck Lever <chuck.lever@oracle.com>

Thanks, since this is an enhancement and not a fix, it will need to wait
till the next merge window to go in.

I can write up a formal patch and let you add it to this patch set as the
first patch, or I can add it to my tree if you don't expect this to get
into the next merge window.

-- Steve
