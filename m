Return-Path: <linux-nfs+bounces-15729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCAC168E0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF288401A1F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89134AB12;
	Tue, 28 Oct 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj++AlAn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BF33375A;
	Tue, 28 Oct 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678048; cv=none; b=E+CiiRDs1YNtoHyUCPRu+KRk5ADwBDd1J53r0PDuwSPGGWavv7IxcNgIpL1atrY14TG+m7UUrPNNRr+TIsqLjH1nuZQ1wEUTXcDOmyDJDUtzN9Hq8nDACCjtyYrSmXz2x3BvRQddUgzA3unBaSYXTLGKLWPsLtOk9Or4qAq16GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678048; c=relaxed/simple;
	bh=6TmXIE1ErW1nB1KXGkfIGafW/uBduxIYiTR3bdatlVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9Aoq4NK5MA5xvFZ5Bx6W255qJLsAWUwzR54mwifjGaeWa+z43E8Uo49RBJtd581YZMcdo7Pzqv3G2c+CHuUqPn9RPuFj84kqdCkLYowuviTW9emHquqYUSezG0ipf1ONiFojVuNb62bEE+8xFHP5xxnjlfnaXMPFszkZ+P6GcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj++AlAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0436C4CEE7;
	Tue, 28 Oct 2025 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761678048;
	bh=6TmXIE1ErW1nB1KXGkfIGafW/uBduxIYiTR3bdatlVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cj++AlAnGZflpB4f4hkVJGUc6pd7F4IGudK+niagBTeAK6Ew+wzIma5f9lxESKhPY
	 BT59wnXnCRj7qZzc0N02GWXkhuXBNT7oAlXBPbsUK8xCV+2UKKXv4ACW/EN3TO06HS
	 Z85UzrFf7SDYnCwJen5uNbybajZFtI5+3a6BM7StycwWLjIMi6y6F2/cx8Pek5V+t1
	 DGr7SYhcUthikLpqsZxXgL8lHW/T98JQXOrLcPnKQhVIkORP6ccZ9ANXm1q3/Ui+PV
	 mdKidhK3KL43QkPnUQkViElQAsy9kmIqqpm4Tw6wNhkyowc453A2gWIO0oUpv5qkU2
	 iOj0tqjk77ItQ==
From: Chuck Lever <cel@kernel.org>
To: Khushal Chitturi <kc9282016@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xdrgen: handle _XdrString in union encoder/decoder
Date: Tue, 28 Oct 2025 15:00:43 -0400
Message-ID: <176167803663.42531.4479861144864515683.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028145317.15021-1-kc9282016@gmail.com>
References: <20251026180018.9248-1-kc9282016@gmail.com> <20251028145317.15021-1-kc9282016@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 28 Oct 2025 20:23:17 +0530, Khushal Chitturi wrote:
> Running xdrgen on xdrgen/tests/test.x fails when
> generating encoder or decoder functions for union
> members of type _XdrString. It was because _XdrString
> does not have a spec attribute like _XdrBasic,
> leading to AttributeError.
> 
> This patch updates emit_union_case_spec_definition
> and emit_union_case_spec_decoder/encoder to handle
> _XdrString by assigning type_name = "char *" and
> avoiding referencing to spec.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] xdrgen: handle _XdrString in union encoder/decoder
      commit: 33489817c0df12155eb3bfc86edca8fc64d204f6

--
Chuck Lever


