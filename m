Return-Path: <linux-nfs+bounces-17049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2183CB7A85
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 03:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40E163006720
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AB1DE4CE;
	Fri, 12 Dec 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="i6jPmsRZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FD1FBEA6
	for <linux-nfs@vger.kernel.org>; Fri, 12 Dec 2025 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505954; cv=none; b=b+H804zxV3QzpILXpY3ALqFWWpRZlsklWqlRNWuD3cw9cY920ryGibl8LUamz1nXRb0kwiBWFB1HMilwKQOUl59dyTYgzCrKfmfequrTe8QdaG1kx1NU6kfeY3llWNYdtIXeRRnR/2rRWRp6uDxNneLO6qRp3FRAAPzCjl9fPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505954; c=relaxed/simple;
	bh=oKmWqno+42Yszq+X+3dPg3C6ZlbSV4utaiC5PwGM8sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU/5iR4lqBaTPhXPkhqMKAvTuMSRPdwVcWDC7btnCuFMWLn6LNgkdwXwUTnrDrh4BhGNBltHJAIc4J5d8qn/0ZclKIdjyZ4Zkv2m7R878UWUvo+wsYvUzNddN3QpZNH5P5B/P2uG48nsiBeoj/czsY6GP2RxwkdQnqd3Av6TtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=i6jPmsRZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BC2IYhd032743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 21:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765505920; bh=kHgJW7HgRu8VCSroGjRmOAwqb8zj56QpPoiLbKKowPw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=i6jPmsRZFsshYqSOPIZXGaEp16grpLapyL5n0LAa2Y6q8+Fs8uoaOx0TtcUMCd9nT
	 2QJBxhWViCMXJm9xiBNNmCNgBmX8ohWnVb+u+NSungMPk4KDsQnj1CS1cxwnmzRsMe
	 wnnEbYZxZl0UAga3IRec8PoDOt70P9QmDHgoBwo4K0Wdd055p4anCouP5qjkiGV0HY
	 RQ99LXn14r/Ocge+yCwLrc+U95yc6POn/QHywjGkdpv9yXUBtv+e3GaIj1CQttTaPr
	 8DL9FWdStVjTIIUGYKrgiC2f5PF9BCJtwx9R7MN+LZ8mLysvkjMBXB2Y7nJIjNp6mo
	 Uuck8DUHWQ+rg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 3E7DE4FB3D3C; Fri, 12 Dec 2025 11:18:34 +0900 (JST)
Date: Fri, 12 Dec 2025 11:18:34 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp,
        almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
        Volker.Lendecke@sernet.de, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Message-ID: <20251212021834.GB65406@macsyma.local>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org>
 <20251211234152.GA460739@google.com>
 <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>

On Thu, Dec 11, 2025 at 08:16:45PM -0500, Chuck Lever wrote:
> 
> > I see you're proposing that ext4, fat, and ntfs3 all set
> > FILEATTR_CASEFOLD_UNICODE, at least in some cases.
> >
> > That seems odd, since they don't do the matching the same way.
> 
> The purpose of this series is to design the VFS infrastructure. Exactly what
> it reports is up to folks who actually understand i18n.

Do we know who would be receiving this information and what their needs might be?

      	       	     		       - Ted

