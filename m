Return-Path: <linux-nfs+bounces-14094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33640B46738
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 01:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97987C4BCB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 23:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C244F5E0;
	Fri,  5 Sep 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYx5nt4T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB43595C
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115059; cv=none; b=h6OcQm/5cX0dx2DDa0GTKQPaE7L+6ZdxafEGVS+Z/gWcwVTQ7JZ0xK8+Djbd7XaeH6U5eFUDrYSBarj7NVXtnAx6SWmuzKrO5zqjwglR6QwdMAXZZebgwCJ03uT2tI6iLMvE8Wc5yk1gKRidjkxjdsJmx1/ujrQgsTrFZJ/pGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115059; c=relaxed/simple;
	bh=8J/Ml4PHumLvl4rPblrw+a6HHWr/0fia4Bw7MH1l0xM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M1njJHdiLSb9DuZBLZbWvmaqI+GdI0iro7uPitbSWimBTS7AZXVQiN/SfcJGuHgGWjuGYRk3SjnR/w4WhZ9cBrWh5EyHrB6hV9w4SPE7QAhSTIi0GakPVFTfaKNwzPTYnsPp5gDnGk7ZzidTiO/N7N3g4QdSLpTPW0zyjBSWYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYx5nt4T; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-544ba00733aso1739273e0c.1
        for <linux-nfs@vger.kernel.org>; Fri, 05 Sep 2025 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757115056; x=1757719856; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8J/Ml4PHumLvl4rPblrw+a6HHWr/0fia4Bw7MH1l0xM=;
        b=jYx5nt4T8eodV7ehXLGObQn2QKhALDU4cGSmonJBkP3Mtmz2lpZuRXOMzowYaASfV6
         sNwdGHvN3v2ed911AzIjRgS/kPbpKNEe6+hrphlBki1GzplLtYXm2aH2GkzJJ2MSi/eX
         F/lo9Rgws2rkA4YG5AinIrVKdblxi54/IFK42PlKaBD2znQjpWdqhrU0fSHqS5GyP6qM
         jgAJpMa2zt2qPj+DtlhCxGepCjZUAkvdAX+QyVB37ulI2PxBnprnV7hSkkXgyx0ooBcS
         cZofuyL68VhuNAw/3+CVz2FEkyipnmjGSjpVBzpSNbqpCnUx5WpRn3MWKpwJegfsskOI
         OP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757115056; x=1757719856;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8J/Ml4PHumLvl4rPblrw+a6HHWr/0fia4Bw7MH1l0xM=;
        b=GPOTmjaXfqIRC2qmbDwVdSxG8o9hSxNhnr1fbcMrLTlqJ3me7NaUoyh4FvVf4FXvik
         pG6i0hIWDA/lLA3yZgklX/0FP0Jk/UgKh68+RTfzUroJowgTCvEo4h+vawxocJzw7uG5
         ExfijNGGpD0CktvmqVHBtpRuCWl55+AuevMgrYrlN130FmsQ8Fd4c92ymbyzTWTR1jGR
         DfF9dP28SDD0Y3wUbN4ghEtVCFKnDx4g20XRVSyAUVz44qUVfLdFXpeLCD1EKxVu6cl2
         /dUXU2vImViz91rDZdVH4eY+Vc+awCy+ntzaYAux3Gw2RArcnKd/D7ijfpYjVMlAETwK
         L4mg==
X-Gm-Message-State: AOJu0YyYuz/k07bf0XUZzxP68IgBFdVgf3CApTGD4rlLt9nvwU0XL9kc
	CsiMBpP5WQ0OwHqcCADbE1lPeKNc4yLCwddczfCYeKZ+Feew6RfKf5bA1KQoyq5BgOoXfOLHaM5
	6KmjNitNfFPh6lkdYg64047a9O5lwrHL1BVnBjjU=
X-Gm-Gg: ASbGncuvgn6YErxFfQVciYgnXbpORRSoeGTBUTYeVY4JRqgVzq5ECyhM1Q45vsefviF
	pOnpGGblRpw8WD7IiYLDno4gs/axcvgFiRkMODkJ2FAnhcmSqqA6UmnDSygY6UNGx/fcjlgYfxt
	MFYbEVy6NNbCoZsHXYRbkfoOqjlUbRFLBkRFlp5i9MfQ0wfK1eCj4ri5BYr8+FqFJsWaxPmQSy0
	Dbt4J7U/ouXaMdXbr4MUXITsuSvMg==
X-Google-Smtp-Source: AGHT+IHMAdD8XLNGmIDWYvbEeisBPvsY+ynz7UH52aJoVpshW8jn4ygHZc0nftyeg+yFuPpgM5TWDgPJ/V75XZtUQNg=
X-Received: by 2002:a05:6122:2a15:b0:544:7949:d36b with SMTP id
 71dfb90a1353d-5473afc9b77mr225382e0c.7.1757115056469; Fri, 05 Sep 2025
 16:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Triston Line <tmanaok@gmail.com>
Date: Fri, 5 Sep 2025 16:30:44 -0700
X-Gm-Features: Ac12FXw-RlxTxIFTkudeHrZtlLJikR9OmKQbo0jmT4cUEeS6RMhSunZg1HDT2ks
Message-ID: <CAEgfpGeGgQZsQeyK+YC7eonT8cqWHwD_x6DByNFpbS4McLTYSA@mail.gmail.com>
Subject: Status of nfsometer - Debian - Triston Line
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi NFS Team,

I am a Debian contributor looking into the status of the nfsometer package.
The Debian maintainer has filed an intent to orphan it, and the Debian
source matches the latest release I can see upstream.

Could you confirm whether nfsometer is still actively maintained,
or if development has ceased?

Thank you for your time.


Triston Line

