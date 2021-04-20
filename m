Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D253D365F16
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhDTSRC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhDTSRC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 14:17:02 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F04C06174A
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 11:16:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 52E807258; Tue, 20 Apr 2021 14:16:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 52E807258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618942587;
        bh=X+GSB2VbMpteuLFWvcBwU16CX56MO2ILcpWCQBsE5Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG9ZcX2vurxO0/owtwd9hOFSZRKZdAcHAfCs2lEop8tUFB5kH1gJnRbB7IS9J4ngA
         K+jFk34dOiTAKXPAy7LrQWdlX6ElWZHfwIoyeNoe0o67RSHiQXJdrSC24Ut1I2RQDh
         4gv0mqx8xTohWkQ56qn5ThXpcYOmJYh/c2y1zJNg=
Date:   Tue, 20 Apr 2021 14:16:27 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Message-ID: <20210420181627.GA7297@fieldses.org>
References: <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
 <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
 <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
 <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
 <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
 <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
 <20210420171806.GC4017@fieldses.org>
 <be1a2b6beab29b3e40277f5fefd6c49b37c32361.camel@hammerspace.com>
 <20210420174036.GD4017@fieldses.org>
 <85b4ca155d1697a714be88a67c505d287e22be46.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b4ca155d1697a714be88a67c505d287e22be46.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 20, 2021 at 05:53:34PM +0000, Trond Myklebust wrote:
> So if the machine-id exists, then maybe we could indeed generate the
> identity using the uuid in that file (although the question remains as
> to why you'd want that?).

I was assuming: When you clone a machine image, either you want the
clone to have the same identity (maybe it's a backup, or you're doing
some sort of migration) or you want it to act like a new machine (say
you've got a base image that you're using to make a bunch of hosts).  In
the latter case you've got to track down everything on the filesystem
that needs to differ between hosts and fix it up.  The fewer of those,
the better.

> However the generated value should then be persisted separately so
> that it can be platform independent.

That'd be OK.

I don't think switching a host between systemd and not systemd-based is
a common case.

If somebody has a really weird case they can always write their own
script.

--b.
