Return-Path: <linux-nfs+bounces-8937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3597AA033A6
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 00:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7FE3A0525
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369F1E0DCE;
	Mon,  6 Jan 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiRjKCL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719941DFE00
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207808; cv=none; b=ngg0LHUacSPe+GmDKfl7yCnUCy091qq5Qad1A91V2vqOwX15a/UsDQ9vLsg+nGY/4LsZYsqVFlHvJ0HVGAasX9DFVxtPs+mnsJHW1YfihpFknmvkI02N7tRilTf9xKkgtpVILqI2Us8kfKRbiTDMTqNGxEQcuV/TjaHl7YBOzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207808; c=relaxed/simple;
	bh=qxgh1MJ0RqUtpSoE/1Qtr3bm6YzOVKED0qv0wbRC6S4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=erye+8bn1TpSUSl0Zz78vWuwgloVxqNT4/tFTfrz9EfKfV14ld7jJdjHT6tJt9lMW7quBKKlv7NvmQG6QBRfcVgfGsDdaCHuz3z3VyNw4nkk/D7SD2QqDcVecBK6XlgOnD/eRD4C3tALWmMoV2iT6cXdqXrcLOQS6lwhanbYJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiRjKCL3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa689a37dd4so177795366b.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2025 15:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736207804; x=1736812604; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxgh1MJ0RqUtpSoE/1Qtr3bm6YzOVKED0qv0wbRC6S4=;
        b=HiRjKCL3DXms7LSvdMHySyniZJfi0VwpP7xYuSdHijkXeKRbODUvt99dSFzDOqV2we
         0u5y8zB4SXPS1gWjai3P6kfrpxJ74tfwJ+26CjThoRt0DGGWzqZH9xGxvkHF10W4rMel
         Aw64hrBEXw2ZNerxwPl3AvI7QeHCAX6Df5uT+6cB9WNHGq4KVj82kW49hGmNTL21BIcg
         dArIu/WoTZNAFuDE51QH/WmteAkOetmoGgEs+H1yyvJhr9leWV1tfe9H5uMZ0JV+vb4Q
         FLcBBBW3IjfK7zMo8z4zm+K0XG6Evp4Ne2Gt+krjhuvjC1AYJfxfcAt/vsRLo31BPiKs
         0l0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736207804; x=1736812604;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxgh1MJ0RqUtpSoE/1Qtr3bm6YzOVKED0qv0wbRC6S4=;
        b=FBO29G/v0aJq92uAYIu7b/YFiJ00QPOhYKx+5jsKeYEq9cCs6/xuLSX4UPguVDSpXo
         PEvDjK62UPMyFLDTKqvHsDtJaYu97CoEffkOWeGmT4meqYI8+m99hvFYL+4h7hofDTlw
         W71bnRPW9dAcDvtUvCfxXCK2jEsHgat3mH6n6h5aaB8v9j3Ei2vMt8oXqTSX+6LKClPm
         tRpzCX7pAiEt2FYDG4qgwdvLHWy11OfY0hc7EtChpRW2lQnt2P0lJPc1/FTq8LaxrJ8e
         Ak5szhZ7ZDpwbHg+woOXXUGEdULTKno1ui5rt2tasre1uuIp626UX+ZUGWK0sCR+CsC9
         1f2w==
X-Gm-Message-State: AOJu0YxrC428QacvPfRxncP+kWTdqDekWpSwVYxiXAzycX4aTShxg8gN
	yoJeyYNyNurkFeUoTm3ylMOUjtESor5TCqG5YCBXT7IgTwxSvNK8ORXwcRZrrnXPF+bGbP+q+/X
	PwikFGr26mlF85yA+gBldxj9uzh+6UQ==
X-Gm-Gg: ASbGncufi6eUr+dLV9Gnh2IdBsFp227IoTDy1XB9nmPehboKTsxTw+YXnbwXfzKBEtW
	5H7SvianYcRmr5Ta2OYnNWg6wH6OXc1BiWuKnu88=
X-Google-Smtp-Source: AGHT+IFuBomZCtT3tj3ls79SRNh642JlVb70tmG5b0J+nNYg55wa3J7LpyR0Qv4NO/2USm0gQM5jiBv0fo/YEs9SL1I=
X-Received: by 2002:a17:907:7f92:b0:aa6:a87e:f2e1 with SMTP id
 a640c23a62f3a-aac3378ef88mr5396349966b.56.1736207804073; Mon, 06 Jan 2025
 15:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 7 Jan 2025 00:56:08 +0100
Message-ID: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
Subject: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear list,

how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and an
ioct() in Linux nfsd client to use it?

We have a set of custom "big data" applications which could greatly
benefit from such an acceleration ABI, both for implementing "zero
data" (fill blocks with 0 bytes), and fill blocks with identical data
patterns, without sending the same pattern over and over again over
the network wire.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

