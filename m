Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C248A2EF52D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhAHPwv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 10:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbhAHPwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jan 2021 10:52:50 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7063C061381
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jan 2021 07:52:10 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A19923C33; Fri,  8 Jan 2021 10:52:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A19923C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610121129;
        bh=JUSRpN0I3wHcITQ/lLH5SGF2OgykUbjK8MK+kClIcdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wakhb0iA2fDSqlQAWs3T74by793TfGjJyQiOpCRayV50ZgKkemDBKNb5di33C4P58
         q6LJQvTqd0rdvU3DkzwJuI2bBLKFgH74p5Uz6adHEq5DMokJif3IW0/UMLnE06Qh/z
         y6MfOUp9v+DeZzd5nidbyWb/VZHJxpiiK4ebdky0=
Date:   Fri, 8 Jan 2021 10:52:09 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
Message-ID: <20210108155209.GC4183@fieldses.org>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <20210108031800.GA13604@fieldses.org>
 <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 08, 2021 at 10:50:09AM -0500, Chuck Lever wrote:
> 
> 
> > On Jan 7, 2021, at 10:18 PM, bfields@fieldses.org wrote:
> > 
> > I haven't had a chance to review these, but thought I should mention I'm
> > seeing a failure in xfstests generic/465 that I don't *think* is
> > reproduceable before this series.  Unfortunately it's intermittent,
> > though, so I'm not certain yet.
> 
> Confirming: does that failure occur with NFSv3?

I've only tried it over 4.2.

--b.
