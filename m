Return-Path: <linux-nfs+bounces-14635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29ADB97E7C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 02:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41781896CB3
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0618C034;
	Wed, 24 Sep 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="YxczO3LO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CE13BC0C
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674102; cv=pass; b=KX7MOuo5bGXO25jtdH/bGTAiC37y9oicqZUJwETgjmYga6G+3UrzaabHo5OFt2JW6+xxH+Jj06Mkk1ozoYmdhwakdkuDnKwj1by2C6jSn9RNmqORil7kE5IjZOR/WmHlYcxzN2PuW0Fiie6sr+22q8F1E3vaeSe/67Y8tzXcFNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674102; c=relaxed/simple;
	bh=cJW0iBbr/0MXGc5IGU7W6QHljNMT9IlVEmEIdyqwsk8=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=nqeLMa2IdefT7e5PKmIjG51rHQLcfOFxQIxSF8kCVw0oIMG64o3xWrd+yj+vfKZHX5ewHFIEEELUHyxVFPYwIQ7NTiFQz6EZ5LDGqQmTEQa+gmYcAB7u6FfhFu7TDIx5lWY+iJSCsky+X64QYpgoAayglIjp6Cu9pX/0Nr6rSR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=YxczO3LO; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674100; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=RcoCtDLhAZKDl+Flyvnu7IvdnN9kL/lq766AdVHCeX2g6YmBRxEuQKWwGt1hwsBUcp6r8hXCns8qISW/dSGlK2t4ZXA/bB35Sk5GYp7nnmBkMXuRkxjuWTF5sZ/WESF7xrkwcJXEag24XiU6g/TMxkNr4HuQS+3e/0G3iYQ98IE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674100; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=cJW0iBbr/0MXGc5IGU7W6QHljNMT9IlVEmEIdyqwsk8=; 
	b=jRlyPTEaAlSU92elLXhBpo9DzhOR5Ttmi7DRUcduHJ20kqlR4hL5SfLUm9KLul3hd2ej37uYl2MQrhMUSZxc6dtTMN+sgftQ0QzSlmdnpX5kLfEIk55eV9WoNxsoJq+urgP2LkJJzVX8WrR9fC4MCdqHAPPMCqBVCqcvFQkFPR0=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9aa248d0-98d8-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671652887462.7463906648046;
	Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=YxczO3LOC3oeLZTGJM4KX8ZZFrL3D89OrUKz0LXES2b8nIRm3zE51P5AxXhzKfqZURxbMeV/gkUvXdmh9ggrE/1fVtYHEnOQqMaYEU19G5wg9IQa4YP/AdbqAKie72MbaK4v6KvBIyjOQ77euGDG5ekkpgsJRs/PNqOEFLLSjnc=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=cJW0iBbr/0MXGc5IGU7W6QHljNMT9IlVEmEIdyqwsk8=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-nfs@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9aa248d0-98d8-11f0-8217-5254007ea3ec.19978ffc5dd@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9aa248d0-98d8-11f0-8217-5254007ea3ec.19978ffc5dd
X-JID: 2d6f.1aedd99b146bc1ac.s1.9aa248d0-98d8-11f0-8217-5254007ea3ec.19978ffc5dd
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9aa248d0-98d8-11f0-8217-5254007ea3ec.19978ffc5dd
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9aa248d0-98d8-11f0-8217-5254007ea3ec.19978ffc5dd
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9aa248d0-98d8-11f0-8217-5254007ea3ec.19978ffc5dd@zeptomail.com>
X-ZohoMailClient: External

To: linux-nfs@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

