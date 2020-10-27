Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D129C1CE
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1819190AbgJ0R2b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 13:28:31 -0400
Received: from fieldses.org ([173.255.197.46]:45386 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780180AbgJ0RZs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Oct 2020 13:25:48 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 027E1C56; Tue, 27 Oct 2020 13:25:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 027E1C56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603819546;
        bh=5Zjl+grA86xTqQqsXe0cBYeVGDK3DUZbp8K34b8F+ug=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=VCAU3iRBiDkvpcl3RMA0NmgivltVE5ClXHZRHVBoOnLgx9w9asWTsrIyVa4TGs07W
         /WW4ZzDqQYUlXT2jq5h1jWV9UKEyIV4dzuh5+tWDZ7IVzcmr8/c8K6Sh1+6DubKXZB
         I7M6ex6x64ahA6oN5YdEOQu10NmtVpxUCNExozC0=
Date:   Tue, 27 Oct 2020 13:25:45 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
Message-ID: <20201027172545.GB1644@fieldses.org>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <20201027060823.GF4821@unreal>
 <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 27, 2020 at 09:24:54AM -0400, Chuck Lever wrote:
> Hi Leon-
> 
> > On Oct 27, 2020, at 2:08 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Mon, Oct 26, 2020 at 02:53:53PM -0400, Chuck Lever wrote:
> >> This series implements support for multiple RPC/RDMA chunks per RPC
> >> transaction. This is one of the few remaining generalities that the
> >> Linux NFS/RDMA server implementation lacks.
> >> 
> >> There is currently one known NFS/RDMA client implementation that can
> >> send multiple chunks per RPC, and that is Solaris. Multiple chunks
> >> are rare enough that the Linux NFS/RDMA implementation has been
> >> successful without this support for many years.
> > 
> > So why do we need it? Solaris is dead, and like you wrote Linux systems
> > work without this feature just fine, what are the benefits? Who will use it?
> 
> The Linux NFS implementation is living. We can add the ability
> to provision multiple chunks per RPC to the Linux NFS client at
> any time.
> 
> Likewise any actively developed NFS/RDMA implementation can add
> this feature. The RPC/RDMA version 1 protocol does not have the
> ability to communicate the maximum number of chunks the server
> will accept per RPC.
> 
> Other server implementations do support multiple chunks per RPC.
> The Linux NFS/RDMA server implementation has always been incomplete
> in this regard.

Can the client can detect the server's lack of support and fall back, or
does the server's incompleteness violate the RFC in some way that can
actually cause a failure to interoperate?

--b.

> And the Linux NFS server implementation (the non-transport specific
> part) already supports multiple data payloads per NFSv4 COMPOUND.
> 
> 
> Restoring a little more of the cover letter:
> 
> >> Along with multiple chunk support, this series adds the following
> >> benefits:
> >> 
> >> - More robust input sanitization of RPC/RDMA headers
> >> - An internal representation of chunks that is agnostic to their
> >>  wire format
> 
> The Linux NFS/RDMA server implementation does need to have better
> input sanitization.
> 
> And there is a version 2 of RPC/RDMA under active development:
> 
> https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpcrdma-version-two/
> 
> Having some protocol version agnosticism in our transport might
> be necessary eventually.
> 
> --
> Chuck Lever
> 
> 
