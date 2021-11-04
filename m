Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E893445B2A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 21:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhKDUjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 16:39:01 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:54885 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhKDUjA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Nov 2021 16:39:00 -0400
Received: from c-24-60-30-97.hsd1.ct.comcast.net ([24.60.30.97] helo=crash.local)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <rtm@csail.mit.edu>)
        id 1mijTA-000Qa4-5z; Thu, 04 Nov 2021 16:36:20 -0400
Received: from crash.local (localhost [127.0.0.1])
        by crash.local (Postfix) with ESMTP id ADFAA11E88FAF;
        Thu,  4 Nov 2021 16:36:19 -0400 (EDT)
To:     Trond Myklebust <trondmy@hammerspace.com>
cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: Re: NFS client RPC bug
In-reply-to: Your message of "Thu, 04 Nov 2021 20:29:07 -0000."
             <bda6f973c4d77483f35440bfa5caa9ae82f4df17.camel@hammerspace.com>
Date:   Thu, 04 Nov 2021 16:36:19 -0400
Message-ID: <7772.1636058179@crash.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> I'm a little surprised that xdr_inline_decode() didn't barf, though.
> Isn't size_t a 64-bit type on riscv64?

I believe hdr->taglen is a u32.
