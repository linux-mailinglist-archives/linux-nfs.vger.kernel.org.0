Return-Path: <linux-nfs+bounces-7584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE59B6BED
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A391F21826
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332021C9EDA;
	Wed, 30 Oct 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU28lu4t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1991BD9DB
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312102; cv=none; b=S4yClYgaWCvewZS0yetWcNCsEsP+6Z01HhiWQf7sHWF4Dattua5ZaoaDGdJREoYkQ+xNKrQiX7ihtudJwTGILS/DnK3qT0ZCDUGKAu2qXKEqV9fJQzID3529clKhISd0zp6M+HuVDaFYME2Bcz253B1v7KE2yT6iJ/UQLJgkTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312102; c=relaxed/simple;
	bh=OvUPBoxLoTIT3x+YfiLXWa9hvNs46MHDvGR0+KhOXgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwqnbWK+zZltRtNbNCxsKkQW3da3q11S00i3Z+A6Jcr51oBygZ7vPxbAqSSti7ocaHjFDrztN4g5eZKcx1Vy8Y+BywV4nMn0uH62HnfpRmAYw9UQwuI4vVzEDxQwuJHkO60BX2RK94MZZ1JmHCH2Nq63MaZgdsvekpD4S5tflaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU28lu4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B66C4CED5;
	Wed, 30 Oct 2024 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312101;
	bh=OvUPBoxLoTIT3x+YfiLXWa9hvNs46MHDvGR0+KhOXgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU28lu4t9wYdd8rG7iGJUfclMkQii1DWGtMXOzZyeTAyI7Vg88/tQ2D1JJrT1av6y
	 q9fKcqZbJBHaq5Yo3uqnPa79nCsVl/bIP5BJJgnQfWJphhSSZtYO5SOkcgBeHZ0lLo
	 NL9D61aN47+/kM10KNF9Zd1CXetYxTu2VdMJxK/IlqxuyZYG1/kaEVFdDdSiQHhWrc
	 ECBnYlfouq0b2j/IP3XKOREHmcQcBq2Q2ZKzyyL3Yh8W9dQIwHIRZTyGN4hCns3YDv
	 H5GETfvaV29QxpWzIZlhNin6PmBcP0Mhv5oK33QkJgO/vWouFaMR751WleykIe4Gaq
	 paKkt6t2r2JAw==
From: cel@kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	okorniev@redhat.com,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2] nfsd: Don't fail OP_SETCLIENTID when there are too many clients.
Date: Wed, 30 Oct 2024 14:14:50 -0400
Message-ID: <173031204294.44815.10771845400873129613.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <172972144286.81717.3023946721770566532@noble.neil.brown.name>
References: <172972144286.81717.3023946721770566532@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=SxqTmj1F9ij0AjnV1MdesE53VYe7057G4HSpgst/AJ0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnIneht1fPBQwCn5ejtfQRBAzhcBnq43QdRtdIb zMFvLRQlhmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyJ3oQAKCRAzarMzb2Z/ l9k4D/9AYOIOjKOty6l1eVh1qNGwd3KpermsyUYg15IVBz7oJwLyu9pj9ITdwmg+VM6UpC5TWse RgO2yF+QyrkrU0IDChp/AeuYkC1XSXsUI3Vy/VqBX1/J6H2p8VqIH/YvmKd5d6QQYuWUtUjRW7T FD8MtEzOIgEacYt0Ec8jwCDMHmPn/EVYNuvUAgSqNqf5bJzkCXL+hx7WlYvtUaM0gC4G685dGS9 IdtW+AJDOZfjbqTZexqBp9slzW9Vzv6I7FQ169dShO+migQ1p/GwpUvAZaKjdBAeBdmi/d8vfrJ bl6lEtaE2W4vxo5uw4WbFhtU/gz9yq3cNHVPQNVjGBnIoXrOm6aKENfpIQHLMGkybXQZUScUyv3 e3Wieu63xEKGZehZFbG75t3Vjfzhxr2PdfkTJVDvFKE3o1ukQN07BSG+MLJaZ2Y0/xOLmta3Pt/ 72X0P263KMJU24ZqicC18LGADRNSunPm1XKqL7NxSJAamThgQnw3tRcdTjICfwMTVwl1WxwVdCr 98vNCkhTa4F9xL9iZbhdYHAbMqBHSJ8QKBYPO3sFSxADsGE+hLf9jT2KGEd1UaYc4TAoE+K1IqX qbhasF3kkf+hFs9r4MsF0vsC3QwcLkxKtXD0pA/sDrMFlFqysc+odJkzvuO0BSADX4hU/OZwgSH 2ZqgiU
 p2xm2H8eA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 24 Oct 2024 09:10:42 +1100, NeilBrown wrote:                                              
> Failing OP_SETCLIENTID or OP_EXCHANGE_ID should only happen if there is
> memory allocation failure.  Putting a hard limit on the number of
> clients is really helpful as it will either happen too early and prevent
> clients that the server can easily handle, or too late and allow clients
> when the server is swamped.
> 
> The calculated limit is still useful for expiring courtesy clients where
> there are "too many" clients, but it shouldn't prevent the creation of
> active clients.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: Don't fail OP_SETCLIENTID when there are too many clients.
      commit: c7b8826b41906db1c930cbb10abb94eb24247f20                                                                      

--                                                                              
Chuck Lever


