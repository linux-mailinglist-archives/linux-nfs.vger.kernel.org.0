Return-Path: <linux-nfs+bounces-16050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6AFC3625C
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 215474E61B2
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2172192EE;
	Wed,  5 Nov 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFsfujQ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EA2264CD
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354067; cv=none; b=SuHOBfiQYtD1PSm3jTsGnzthsgACitHbe6RdVLQR2zGA6D58ibbnxt4xkiIdakJxvsooXZupThfHD+X8kNFm12vdeymR88Vk2MbqDQeHHoTFX83bU59DGTruiAM8+/SBj22VqbegWE1QqbpOgitboTNdx6nfeCbRmSGpyjQo0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354067; c=relaxed/simple;
	bh=izNwYZ9wCIopceAPj1FGUdw6CLRJ6MmpV1QqQ0wN4K4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LE6s8cQ5CRSTUHrxkHFV6maD0s95+vQjXuGCxbozI+nb40Ucf5ZKJ4Kkw3gbWbiE4axPwxk19IE76YYm8jqgOfGtiQx1qeIDgfkaL17JhGEWgDCokNSCg6Ripr7b7svGN4dKwUgJQecVFsJ6XhuqGbyjlUOUrIa85s0ySre2uPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFsfujQ1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso11371325a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 05 Nov 2025 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762354064; x=1762958864; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=izNwYZ9wCIopceAPj1FGUdw6CLRJ6MmpV1QqQ0wN4K4=;
        b=IFsfujQ14iKdSx4SSauYgHKhTAKiIIgM7Tv82fTJ3D9wEEA3TB7W+dT9MU5QRUjCGw
         +GifySLI4mwcG9e1l2nsluSUk8WpqMrA9Kuv1XoHDP1rlMJ3MOkTFeASFrgMuCM7H3t0
         yxu96ScnXu77q3yW+77Fe9bMZ4V8TSFPGTnclB8bSVZbIxFA8tNhV3hO/PPXWbj049hs
         PW39m9TdAYkr/AW5gchhy+2PO+DWthPCQ07tcfPYwzTUVpsdePupll3Tpl4v9Bpb5kq4
         iCoaWZ020bxiPNyTZtFj12VHhmNRCRJy1sqBKNoROBfWXc9gYkrVd25ZvZRFns24DpoA
         YnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354064; x=1762958864;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izNwYZ9wCIopceAPj1FGUdw6CLRJ6MmpV1QqQ0wN4K4=;
        b=VNV1Hyn1BRD+8j0Ae+YCGybHgQxKCLlUVvDZoyBc/Q79kTZwIjkFeh8k+pFhKcKrx2
         tEWYoz5E8hIuXMBh8AGyTcqnGt5cSnMJfr1+gz+gqsiiQhwA6nBcN/ddhbeq20cDwCfF
         6mbpSHavL9E1LPgq7XDf4AgumylqXMtpJCMKnpXF2wZDr4DH5OvS2tD/yYKhDsnQpurR
         qnjq047PoEEYCpi1tiiw/AvrjyAGTTbWHCsXcomoDXHo3w8vGVEzrcIlyR9BDQx7vktG
         hHZCP6WeJLC0dQ/UEir1jYSRquvGU+KLQvUwCp2pdoE7URbRYwpGjP2j4+dSf6/I7HdG
         wrYQ==
X-Gm-Message-State: AOJu0YxCz3KxFICy/gciby2h77H6748FiouvGvgDBNO55L4sY0KXwO2O
	lfgEO5fAbxsWOaRXebjiUt3JyWMfQDv2pCrOQdkKQi3cP2LhWnIYcVwYjOv5zuEzzL2dnFnVRSS
	mYEkG1fNx8VLr8zoBybEXjwUDjT4nuitQX7dWlmY=
X-Gm-Gg: ASbGncvRqlkvag10qPyNJZ7ja2DQtUR7hGMwOa08PkxMXbJ/asBokp1xdmXmbBEjBZa
	WQMh4mnTDUTEZ08T/PHjd6dtLr2zPnD8ukt5CUI33gjgyREkosFAy7VSbAO1ACo95J0q/DBvI6X
	o5tBH+UGM7NeJUl8VM/7JI+ihJFTz3Djbkkdqubax+LRPXzoVEa6ZLd+Zuqn7ooE6cgkdKbwIZT
	x6+cffaR6M3c57YkVRfgaQcrYqL2CBtU5W+4GYg9gdDMbqYjl/8Wq99aaMf
X-Google-Smtp-Source: AGHT+IFxbR7YCRXSqulwkbGMzJnZSinXjMUX4hx7LuBbWjca/RbvfgWxYlVGRPLEuU3gGplStqe5FpiWW+euHkLHqFY=
X-Received: by 2002:a05:6402:40c6:b0:640:c800:f5d2 with SMTP id
 4fb4d7f45d1cf-64105b80aaemr2979253a12.26.1762354063856; Wed, 05 Nov 2025
 06:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 5 Nov 2025 15:47:07 +0100
X-Gm-Features: AWmQ_bn1nQ_jGGyIPnYVIrUwRt5AQlIpILM9YFJllkkLbn29-3QTK8N_NZ0n3VM
Message-ID: <CAPJSo4Wa4EGCTQhfK7O9S9O7rmkb5aQHg85_R19FJHqCGi1Usg@mail.gmail.com>
Subject: NFSv4 server sets/gets FATTR4_HIDDEN, FATTR4_SYSTEM, FATTR4_ARCHIVE
 attributes from Linux "user.DOSATTRIB"?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Is it feasibe that the Linux NFSv4 server sets/gets FATTR4_HIDDEN,
FATTR4_SYSTEM, FATTR4_ARCHIVE attributes from Linux "user.DOSATTRIB"
XATTR used by SMB/CIFS?

This is for MacOS, MacOS X and Windows client support.

Lionel

