Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E6E48DCDF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiAMRYF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 12:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiAMRYF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 12:24:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD97C061574;
        Thu, 13 Jan 2022 09:24:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CED661913;
        Thu, 13 Jan 2022 17:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B5C36AEB;
        Thu, 13 Jan 2022 17:24:04 +0000 (UTC)
Date:   Thu, 13 Jan 2022 12:24:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-trace-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] trace: Introduce helpers to safely handle
 dynamic-sized sockaddrs
Message-ID: <20220113122402.74f73553@gandalf.local.home>
In-Reply-To: <164192756765.1149.13872546013201834510.stgit@klimt.1015granger.net>
References: <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
        <164192756765.1149.13872546013201834510.stgit@klimt.1015granger.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jan 2022 13:59:27 -0500
Chuck Lever <chuck.lever@oracle.com> wrote:

> Enable a struct sockaddr to be stored in a trace record as a
> dynamically-sized field. The common cases are AF_INET and AF_INET6
> which are different sizes, and are vastly smaller than a struct
> sockaddr_storage.
> 
> These are safer because, when used properly, the size of the
> sockaddr destination field in each trace record is now guaranteed
> to be the same as the source address that is being copied into it.
> 
> Link: https://lore.kernel.org/all/164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net/
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

This looks fine to me. The only comment I have is that the subject should
be "tracing: ..." not "trace: ..." as "tracing" is what we use for the
tracing subsystem.

I'll test this out if I get time.

-- Steve
