Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300C45FBCB5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJKVOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKVOq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 17:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB5B87F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665522881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5PErbQ5uCJrP2izWi5iAsQsDc9ZOv/4e+hd/70T5gVE=;
        b=OXMYVkcs8mL3ocQYm15S4zB34F6WITXS56iCCn+mtdYC5TZjBljYAFH1Tk4Xz3Kled8FeT
        Nc/+fS9gpQQb7N4HW1e7MGEbzRIzPWqNGGMtjYwQdlcCQmPSKHDNnx1rysMtaMGiW2l95d
        DNxO0M3tbpMCpGVbxGj8qlTqme/ICcA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-IO_14RgPPXu5XQbOYqKwlw-1; Tue, 11 Oct 2022 17:14:38 -0400
X-MC-Unique: IO_14RgPPXu5XQbOYqKwlw-1
Received: by mail-wr1-f70.google.com with SMTP id l16-20020adfc790000000b00230c2505f96so2090082wrg.4
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 14:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PErbQ5uCJrP2izWi5iAsQsDc9ZOv/4e+hd/70T5gVE=;
        b=yA38KLciZnqJ/sl/f4ESr8bdKGoLEQd22P5FLco+0KpOWvtizmT2XeykD5VI6FtOvJ
         JaVO/vZvTjuVFFirBME8zxYPEBDN92SzsN48xlbjbbh4pJLxXSM8YJBZApwi5gon9wMO
         KCZH2s6R604iGN5vzU5zxeEwv9ipXveTyzwXzfKy8DGNFvp3woeuCnfHUyd5lbIBxtkj
         qHUlJ8BEKqK6fz8qP1c818WPG/4x+D1L7U3supw8YSjEzzQKvYPnm7UIa4luZoNIGoQ5
         jhMYFRREXChaVva94Wxh3rwj2OFfpB4VDSFJOm3B1tbvAXCjPaqUT747qKTzgrpxPf6+
         7G7A==
X-Gm-Message-State: ACrzQf1nj+NdnlSjggCJ/INqGncBb00k2WQEN7Qe2k9lD+a857lcAhDR
        8sDNSYInsYyW3eFEzuWtdfbE5spnyyzsrhqiAONX2++xzxXTsNzvR+vwceD22SUIIH+r+TjBCXy
        pDV2uXmAx8+NrnoxoPBZC
X-Received: by 2002:adf:e189:0:b0:22e:cbf4:1148 with SMTP id az9-20020adfe189000000b0022ecbf41148mr14357670wrb.47.1665522876551;
        Tue, 11 Oct 2022 14:14:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM60SuQBYvyhxjDLOp9+KNIHBLfWT0rYxduVPPt0flyuuosHx3rsIzDkgxtPae72FfQY2i3TVw==
X-Received: by 2002:adf:e189:0:b0:22e:cbf4:1148 with SMTP id az9-20020adfe189000000b0022ecbf41148mr14357659wrb.47.1665522876372;
        Tue, 11 Oct 2022 14:14:36 -0700 (PDT)
Received: from ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (ti0005q162-1960.bb.online.no. [212.251.164.190])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b003c6b67426b0sm85887wmq.12.2022.10.11.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:14:35 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:14:33 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <20221011211433.GA13385@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
 <Y0QyYV1Wyo4vof70@infradead.org>
 <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
 <Y0UKq62ByUGNQpuY@infradead.org>
 <20221011150057.GB3606@localhost.localdomain>
 <a0bf0d49a7a69d20cfe007d66586a2649557a30b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bf0d49a7a69d20cfe007d66586a2649557a30b.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 11, 2022 at 11:57:53AM -0400, Trond Myklebust wrote:
> On Tue, 2022-10-11 at 17:00 +0200, Guillaume Nault wrote:
> > On Mon, Oct 10, 2022 at 11:18:19PM -0700, Christoph Hellwig wrote:
> > > On Mon, Oct 10, 2022 at 06:56:50PM +0200, Guillaume Nault wrote:
> > > > That's what my RFC patch did. It was rejected because reading
> > > > current->flags may incur a cache miss thus slowing down TCP fast
> > > > path.
> > > > See the discussion in the Link tag:
> > > > https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/
> > > 
> > > As GFP_NOFS/NOIO are on their way out the networking people will
> > > have to
> > > do this anyway.
> > 
> > We can always think of a nicer solution in the future. But right now
> > we
> > have a real bug to fix.
> > 
> > Commit a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all
> > rpciod/xprtiod jobs") introduces a bug that crashes the kernel. I
> > can't
> > see anything wrong with a partial revert.
> > 
> 
> How about instead just adding a dedicated flag to the socket that
> switches between the two page_frag modes?
> 
> That would remain future proofed, and it would give kernel users a
> lever with which to do the right thing without unnecessarily
> constraining the allocation modes.

The problem is to find a hole in struct sock, in a cacheline that
wouldn't incur a cache miss.

So far the best option seems to add a special flag in sk_allocation,
which would serve the same purpose as GFP_NOFS in sk_page_frag(). But
that'd mean clearing this bit every time sk_allocation is used for
memory allocation. Not really something I'd propose for stable trees.

> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

