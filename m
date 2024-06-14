Return-Path: <linux-nfs+bounces-3821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41458908943
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE63B25488
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6740195F03;
	Fri, 14 Jun 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ujJgfi3t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38B192B7D;
	Fri, 14 Jun 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359415; cv=none; b=NpbS8PkKMmghKLd/sQU/P7HG9KvKVJEj99Q0bOiArdus8bfVLTNB+viiBcGZKqmNvzkGLPPbtRtgm6Uzw7kSa0jpafYfhyz831fD4ji4z5zaspVfJPPBC1eJ1AgXYklHI3MWbtvU67z0X5Edb6F9WgH12x2U4ltdP9Fcn2QrCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359415; c=relaxed/simple;
	bh=79Sp5ssPZoPT9qKyEZxZNvuP0Lw4eVu9irWLP4+NS7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1O+jNbk/aS3yL4Q+2/dJ49qb+tqy7zQ93ek5hM8dxaXoZ9FzJ60tOuPLhWzrD8caycPNYgPD77oUBz0182jhKnrUNPD1ZaMoHdvCqMNpGabhR6funiLEWBET6doJY6oMvoC530Y9/0JsXQI+jSO6Ks4deUO6gt0z3S91fWImu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ujJgfi3t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Y+h9mnigpjpNwUAOXWawpV3AcyMYOp0Q9u/JSf0OWCw=; b=ujJgfi3t+Id15NzIWQvK0d9stL
	L3jS8QFAFFYlnPPhRu4LgMoMcSBHEI/OmyktKGKVaUmZvDvtIsqm7sa7uejK9asGqze2BpHixp0Ww
	VeBrtv1kfL/GvMDWUgxDULH6QENz6YNyyADTTNJM5JIwdqF6hr6B7cFc7HA/azrCUgKh9oyd3jDq9
	DEeFD8S9yxP6Wtl6GuzJjNhCV0Wz05p80rj52AAvV9R5f69nQ73QMYSlLiNJKnKYP/iQWmOXthvb9
	hwBCyVAI+1p4DnLLoUnBgoRaYwLA7VlEqR1XE4px3OBBl2FjNDtPqffzZ9gg8HmKMV/UawfGPMvIm
	GXReHQIA==;
Received: from 2a02-8389-2341-5b80-6543-87c9-27d1-cd7c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6543:87c9:27d1:cd7c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3mO-00000002KgB-0Qk1;
	Fri, 14 Jun 2024 10:03:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Steve French <sfrench@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org
Subject: fix swap on NFS
Date: Fri, 14 Jun 2024 12:03:24 +0200
Message-ID: <20240614100329.1203579-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

as of 6.10-rc swap can swap out larger than PAGE_SIZE chunks, which
trips a VM_BUG_ON in NFS.  This trivial patch seems to fix it to me,
but I haven't really figured out what Fixes tag this should get.

Also cifs has the same VM_BUG_ON and will also need a similar fix, but
I'll leave it to people with a working test setup.

