Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4912D458646
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Nov 2021 21:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhKUUVs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 15:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhKUUVs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Nov 2021 15:21:48 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCDC60D07;
        Sun, 21 Nov 2021 20:18:41 +0000 (UTC)
Date:   Sun, 21 Nov 2021 15:18:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Thiago Rafael Becker <trbecker@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sunrpc: fix header include guard in trace header
Message-ID: <20211121151840.23af5f65@rorschach.local.home>
In-Reply-To: <3209AFD1-006E-48E6-A3BF-59C76ED6A17E@oracle.com>
References: <20211117132630.2837733-1-trbecker@gmail.com>
        <3209AFD1-006E-48E6-A3BF-59C76ED6A17E@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 21 Nov 2021 19:33:46 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > #include <linux/tracepoint.h>
> > -- 
> > 2.31.1
> >   
> 
> I can take this patch for v5.17 if no-one else has already grabbed it.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
