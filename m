Return-Path: <linux-nfs+bounces-451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B28094C9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 22:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A4528265D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186BA840CB;
	Thu,  7 Dec 2023 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CWIkn3yc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E681727;
	Thu,  7 Dec 2023 13:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JRqlC0m2HmQ6Q73zpLh1BJg1SslxUknYiWPpL10AV9g=; b=CWIkn3ycvoBevfglURIl/8u2Qr
	wrCjMfUSNpFV4uKR8+6hS+2YMYRDfaE8PPcFWnAuvXbCQhvASsAOQOHbDRmZ03+w37vzj4H1yYAwE
	kbNsOBkG+cxqBNGLgk21INpxUeApkhOuzvXtLjiwbW4Tznh9/FctywjesoWOisjryVQX0A8y4hJ/W
	t6bFCLfaEIb3nYKZCQOEXi83EJ6qBb11mJeFU4r1eOwBnpOYtI9eP11qsmvy5lxDAi+syinWKepDj
	zCqK9Tbg4ao9r5H43578TFriztHCv5L4vDiun6leQQfGKSopB1Rus16i3atlvXTvnmkMCuWRY1q72
	QePMsqBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBM52-004PsR-IU; Thu, 07 Dec 2023 21:38:48 +0000
Date: Thu, 7 Dec 2023 21:38:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 59/59] netfs: Eliminate PG_fscache by setting
 folio->private and marking dirty
Message-ID: <ZXI7aGHkxZyiytXg@casper.infradead.org>
References: <20231207212206.1379128-1-dhowells@redhat.com>
 <20231207212206.1379128-60-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207212206.1379128-60-dhowells@redhat.com>

On Thu, Dec 07, 2023 at 09:22:06PM +0000, David Howells wrote:
> With this, PG_fscache is no longer required.

... for filesystems that use netfslib, right?  ie we can't delete
folio_wait_private_2_killable() and friends because nfs still uses it?

