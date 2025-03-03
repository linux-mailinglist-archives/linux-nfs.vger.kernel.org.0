Return-Path: <linux-nfs+bounces-10439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1367CA4CDA0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550B73A45D2
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DB2356B0;
	Mon,  3 Mar 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfSBA9Jo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47C1F03C7;
	Mon,  3 Mar 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038143; cv=none; b=ap5oTw37rRk8EjifbSbTRZo4U0/SgONRuDXCS+RkBuxd+XGRQcRXzf+TUhPDdVFffrlPk/Vs2JEVYG/dSa0p6qbkRWvcSrmaeJv8/tam92yF/D8QmtLlneSUSAEZvUIzcsrmXPuFO44fHnP7VGYDaTlLWDnpVl0MluRh3bJFjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038143; c=relaxed/simple;
	bh=5N3YZ6i4HZxnoJ/0kJ4y+E/QTN/YY73jQxBOjgAChzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7ZvHzrmaWjLw7CKBU2YdJk1DaF9eInsxr3cYPdgwtsFRf3TyxJfaGX6u1L5GVbjQnjX3nEp7omMGQSOlMb7VhaKnsyW5QFQjQPI71Y3A6oQ3msl8ECqsp1AATxXfhH6PJf12ukXvQGOP3rvBVhI+N213KE9999sbwv8g9EJkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfSBA9Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55061C4CED6;
	Mon,  3 Mar 2025 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741038142;
	bh=5N3YZ6i4HZxnoJ/0kJ4y+E/QTN/YY73jQxBOjgAChzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfSBA9Jog4B7xhBzaV5pZSDkZvkF1Zn21X8ULNp8rpMaz49ZsX6t6ZgOIBwIqiLm0
	 Z3FXqm/hnlohzpR20ewudiVUR+kzEiqPoG4Irl0qQZ4OjalCDt6o1YJx8FfGG9PrRl
	 vaY+h8eSyAGRmTBVsY7u623L1cnDhPyiDc7BvMtGJwEvGg/nE2CW7FTzvyR8cd56Ia
	 Ahwu+cLuTFbC9b892bXe+jRpOc6/ictaR04cXbr5OWxfUm0+Xioixwp4C3C8JuhhYk
	 bcxPJhURiMundpg+NHC9CXngi1ajx4w2W1rKb/5gB85pvGUX4RP7pryKw+JV988Csl
	 N35VbejhyX8uQ==
From: cel@kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	nicolas.bouchinet@clip-os.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
Date: Mon,  3 Mar 2025 16:42:17 -0500
Message-ID: <174103811019.30862.13359233350686241870.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org> <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 24 Feb 2025 10:58:17 +0100, nicolas.bouchinet@clip-os.org wrote:
> Bound nsm_local_state sysctl writings between SYSCTL_ZERO
> and SYSCTL_INT_MAX.
> 
> The proc_handler has thus been updated to proc_dointvec_minmax.
> 
> 

Applied to nfsd-testing with modifications, thanks!

[2/6] sysctl: Fixes nsm_local_state bounds
      commit: 8e6d33ea0159b39d670b7986324bd6135ee9d5f7

--
Chuck Lever


