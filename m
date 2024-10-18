Return-Path: <linux-nfs+bounces-7274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F69A3F3B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46747B20E33
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047144C8F;
	Fri, 18 Oct 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOPQPIHl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9921F947
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257224; cv=none; b=G7nmF7JNi8+EXZ9Ux96c0DU5Dt6LjD8MvL8dBzWalj/LDUM9dUtyVl+QTz+s3qbGWibT27s6yXO0miAeUbdsN02f0qxIeGrDNooBn6grJSN70ngMyKPnfNeoC/TyelnH71MChvowwb7EmQwcXn8y/tWsoOmfNZW0ERyz+I6yjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257224; c=relaxed/simple;
	bh=PV9XqS14LDMfObUfEN31GzQvAi6kaxWLJiNHNv21qeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRazC71CbvuQPPe4/ea7S9F2GhwA1AFtn/5PEBYMcA8AyEsHoAS6aUd/TqcVmsahOXe9MXcVnzPGviFtwIgobIf3JLIzFbkeJDdAPJJykKO9gVXYUVuJ1T3y86jwUPD2LRUGdNdmR8atNXDXWkXn+xzyVaOuYHNPl42u1OdOFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOPQPIHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729257221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KF99OO+kMukGUcoubRHamA/a09r3mzofmZndAnaxg4I=;
	b=hOPQPIHl8PubLbUYU6Hdy5A3W/gPNxRicEwgwxrwnEeUroU2lyCcniRbqAa/w37b68thm9
	mOlA6Mwz3orr5hPBvxOpvPTnQ63IVSNR0Orogur4XK0YVeRk9D+vJlzSK5TY0icyuESh5c
	cJjQz04VcJm2Ptoz/W/cVl3m4jZtnZk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-u_bkdSTzMhOnJOCQnntH7g-1; Fri, 18 Oct 2024 09:13:39 -0400
X-MC-Unique: u_bkdSTzMhOnJOCQnntH7g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbeca2b235so35837096d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 06:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257218; x=1729862018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF99OO+kMukGUcoubRHamA/a09r3mzofmZndAnaxg4I=;
        b=ScS18wMuB/Ajb/hKTcHU0yB2YGir599bHbFJDX8f3GMyi3LkmZomqjRJ8OAjULuTZJ
         yLtaO06dHPGR02rgOW8OwgDjex7VuZiQOvgIxd3MClXhpVUySrGtfD92pU47eEjwwTij
         Ia9eNB6VpiMyUPnDsgwRoKALYzbSVwzHdTLiUplXAXzT+x1vxfamYU+CxQjH1MHsmT/b
         d3MbH3ek74YfAaXA2SAT0MW7L/LeQobGd5fd4T7CEgup2QeSWy1bl67oeNxEWyR6oEWd
         0xwf2t3rSWnSal7J89jAc4R8aS+dlSvgh0WObeKhv9QaNxDSxtxW+w7WJWdOrTdtGCW+
         49ew==
X-Gm-Message-State: AOJu0Yx+0ejIazmHd889FDWB0mTZqQlvIm3MbknujzEmhfTlAUET6Y9A
	GflvwIceB0SRehjKZQD8dnXx/O6e0TEN3po7Vnj+/0x2ZJLL7aYqmUJAdOTFxJtA6f68yL14xrL
	PbG5H+RuNIUEr7ByDGSXUxcsSVrEZQEGo5qJvlqnCaVPjgM3eqJbonfExlrXrftdJzw==
X-Received: by 2002:a05:6214:4b0d:b0:6cb:fff6:8f28 with SMTP id 6a1803df08f44-6cde15eb790mr36845926d6.40.1729257218646;
        Fri, 18 Oct 2024 06:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPCiT+z1mQdDeQro/I6JGqJexNSLs0sk5aN0hZJ5pqM0VLrcdZG8DUOCm9z7VDgOqLsiNsiA==
X-Received: by 2002:a05:6214:4b0d:b0:6cb:fff6:8f28 with SMTP id 6a1803df08f44-6cde15eb790mr36845676d6.40.1729257218329;
        Fri, 18 Oct 2024 06:13:38 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.130.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1179295sm6754476d6.66.2024.10.18.06.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 06:13:37 -0700 (PDT)
Message-ID: <622276d1-0566-4b6e-90bc-c6ec3e1da47a@redhat.com>
Date: Fri, 18 Oct 2024 09:13:36 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils 1/2] Fix build failure due to glibc <= 2.24 and check
 for Linux 3.17+
To: Petr Vorel <pvorel@suse.cz>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: linux-nfs@vger.kernel.org, Richard Weinberger <richard@nod.at>
References: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
 <20231026194712.615384-1-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231026194712.615384-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 10/26/23 3:47 PM, Petr Vorel wrote:
> interesting, I yesterday sent patch [1] solving the same problem (although it
> might not be that obvious from the patchset name). Let's see which one will be
> taken.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/linux-nfs/20231025205720.GB460410@pevik/T/#m4c02286afae09318f6b95ff837750708d5065cd5
There are a number of patches in the above link
Could you please post, in the usual format, that
fixes the issue.

tia,

steved.



