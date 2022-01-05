Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F113C48557B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiAEPKK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiAEPKJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 10:10:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F64C061245
        for <linux-nfs@vger.kernel.org>; Wed,  5 Jan 2022 07:10:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 12EF372FB; Wed,  5 Jan 2022 10:10:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 12EF372FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641395408;
        bh=1xIHFA0oTu2u8kaGI3xeWhZwG4i7oodMRE5u8AfE7bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzO5qsjTKFxtwvwUYCKOTuF4zPmsWD/J7ffFsQkPfXRYC+0aCt/lKYafqboDc0m51
         YehV/+cwcS2n3IwH6ZlyIf+nWeKA4fPLnmgnIBbm/gqBMR6Al27oPQrFjAwQsL2HSF
         Wki9f9L+wRYU6GcT3nBteRJ4ax72Qmi/MosV0Bfo=
Date:   Wed, 5 Jan 2022 10:10:08 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Message-ID: <20220105151008.GB24685@fieldses.org>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
 <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 03:05:17PM +0000, Ondrej Valousek wrote:
> Sorry for confusion and maybe dumb questions:
> - The aim is to transfer these attributes via RFC8276 (File System Extended attributes in NFSv4)?

No, NFSv4 defines attributes for all of these.

RFC8276 attributes are purely for user-defined attribues, not for
anything that the server or filesystem gives specific meaning.

> - AFAIK support for RFC8276 in NFS (only version 4.2) server is since kernel 5.9, right? NFS client supports these as well?
> - The patches below implements the feature in both, nfs client AND server, right?

Client only.

These would probably be quite easy to support on the server side when
the filesystem supports them, but nobody's volunteered to implement
that yet; patches welcome.

--b.
