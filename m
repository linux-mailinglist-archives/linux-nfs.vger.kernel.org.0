Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE32537D0CE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhELRmz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 13:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244885AbhELQvV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:51:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95F661002;
        Wed, 12 May 2021 16:26:24 +0000 (UTC)
Date:   Wed, 12 May 2021 12:26:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, dwysocha@redhat.com,
        bfields@fieldses.org
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Message-ID: <20210512122623.79ee0dda@gandalf.local.home>
In-Reply-To: <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
        <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 12 May 2021 11:35:02 -0400
Chuck Lever <chuck.lever@oracle.com> wrote:

> Since commit 9a6944fee68e ("tracing: Add a verifier to check string
> pointers for trace events"), which was merged in v5.13-rc1,
> TP_printk() no longer tacitly supports the "%.*s" format specifier.

Hmm, this looks like a bug. I should allow the %.*s notation.

I probably should fix that.

-- Steve
