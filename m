Return-Path: <linux-nfs+bounces-12624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C3AE36DF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FB17A8786
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E51F09B3;
	Mon, 23 Jun 2025 07:32:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB11519A6
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663933; cv=none; b=YCnh+aI4hbuegPW2RpXdguA45RzDbKy/JZbTEQqcd6FZkktrEfPul8NKq9VZsv5kp6zySg0EqLwZAgTzU6gvIONQfd84q6aHU5Ri0lzlHZJTTVGP5Vihmd92OM27hfOsgHW9pvInJDm8u/Ei1RmFiUEeYAu0YOdudoWpw4q2F2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663933; c=relaxed/simple;
	bh=yl0L6UOq1YCs7tvN+SWXtUWV+cauO6hqGnz5VZyyer8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZapITqO563StUZ3g6/HbkX3plcnL/k0vfARLDxLG4pn0ZNCArDPgbb5+J89AGzIjetETJGgvWF/BheAXlJSXFWZyBgvCKegG0PFoSMlQRbUhaM37026sWFh5u/coXycT6cfvSyOCq23r4NbT64oq1hg/dBCtAoBJcOwmZbWo5p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54906227A87; Mon, 23 Jun 2025 09:32:06 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:32:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 1/2] NFSD: Access a knfsd_fh's fsid by pointer
Message-ID: <20250623073206.GA32697@lst.de>
References: <20250620123155.271392-1-cel@kernel.org> <20250620123155.271392-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620123155.271392-2-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 20, 2025 at 08:31:54AM -0400, Chuck Lever wrote:
> +		fsid[0] = new_encode_dev(MKDEV(ntohl((__force __be32)fsid[0]),
> +						      ntohl((__force __be32)fsid[1])));

Maybe avoid the overly long line by reducing the somewhat pointlessly
large indentation?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

