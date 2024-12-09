Return-Path: <linux-nfs+bounces-8466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52A9E9B08
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E6D282A1C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55730136358;
	Mon,  9 Dec 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TKmw/+0T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CF1369AA;
	Mon,  9 Dec 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759958; cv=none; b=QoQJcZA/v00Fn1GUqR2Fw13VU4Z34/sG1nOHmwiKlvkd2bx74E/1y3OUgrmZVXHBRy6s1f8skmit+0wffGgAYA2QkTXS9Dswh9JmnQJeuEwTq8LEpTiQyS/CFA4Sn2EioBAtHCywKwg9lO8IZ0gI+zyicMhoZfp0U9BVcQ6ayT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759958; c=relaxed/simple;
	bh=F3NaVXHFPn31PLAZ9bxcAGz/QrlHVOIwG4AkJKgtBU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKPlDyFFkOMqTG2FMnhF9Esa90zNPziy8DQ3qGLoInQXUdTKLXPqhLoVgVkbr960BebrOfr1ho4fcwT4fwbBD+SP3gaijIQABw9y6uV8uVRwx6iPwDXo7v9lb6wYZrlFsMaktzMSqUMJn/FSe/MyibfVdSeOYq7u9QXo+IHY6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TKmw/+0T; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by smtp.orange.fr with ESMTPSA
	id KgA7tSSD4eELzKgA7tlTyU; Mon, 09 Dec 2024 16:59:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733759947;
	bh=F3NaVXHFPn31PLAZ9bxcAGz/QrlHVOIwG4AkJKgtBU8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=TKmw/+0TJD1Q9EguFlaRo40+XIR7jgqiiVSCBdccxUOzcppaXVQH4cl8qB33DIndR
	 qR2qjKyzDmQADqzYRWWf0XzQ7wSZHIBu+SQAccVIq7s9EYE+QplIA0sG6hWSmtrjk6
	 VCtWVbIIX0PAS3v4GVXbO/tdjkapE7aWCzRTz56WZY7i0bJSDVcmNkXnmW/Igj5Tco
	 Xwu8Uv47qLB6mF3hR6IwF/Xo38/BUmKl2xtt4LVmP2ILwITcN7N3GOGkfTou1D5pDB
	 rnQCe9cNLKJZY0NVfKiCsVuFEdsQOWEb67WF3glKpVvBszC5ZFwOG/YDAlKY8YkwWH
	 TLYK5za89jD+w==
X-ME-Helo: mail-ej1-f45.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 09 Dec 2024 16:59:07 +0100
X-ME-IP: 209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso282891966b.2;
        Mon, 09 Dec 2024 07:59:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFLD4G/DlTUUI6tYY8injTXcBDNxSzO/SjbYC840Yp6mBiONwaa0N1vle4SQosn+g9AndSzCPfQktw@vger.kernel.org, AJvYcCVR12lFjZfCSSRMA/RjSLYXDOJcmxnBf4dY2ofhEFHPgYh9280r4SgY+RZYJXxiAQ9tZe11xVUEw7JabPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+/uJwX5pHfnH4dH+DkJITzi65soqk98F4nwnAdnR8RAQmB3u
	13AQ/G/tLY5DIj+UPImVKn+H3IyFDe9crJddHNKV+V4q580eDDBoup0n7NuSV2fzmz/HzQVA7Yg
	j8wKEbPs/cmUl7cLi8Xz1zV/hdmk=
X-Google-Smtp-Source: AGHT+IH4aJhFvwtUp3hZb1sWt80GPTkUpT6crHeHnZ9VWrKhmAo492yeyCJ0kHBea1l1IMFcuzD08tumFLcazqDsk1o=
X-Received: by 2002:a17:907:3a98:b0:aa6:375d:b96a with SMTP id
 a640c23a62f3a-aa69ce6ca55mr99458566b.53.1733759947308; Mon, 09 Dec 2024
 07:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr> <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
In-Reply-To: <6c287aa1-9d94-467e-a85a-7b7076fc080c@oracle.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 10 Dec 2024 00:58:56 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLH7dprfX9s_Kqg19XfHRTm-ubPnGjZ+x5=+pk5x4qD2w@mail.gmail.com>
Message-ID: <CAMZ6RqLH7dprfX9s_Kqg19XfHRTm-ubPnGjZ+x5=+pk5x4qD2w@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fix incorrect high limit in clamp() on over-allocation
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, David Laight <David.Laight@aculab.com>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon. 9 Dec. 2024 at 23:47, Chuck Lever <chuck.lever@oracle.com> wrote:
> On 12/9/24 7:25 AM, Vincent Mailhol via B4 Relay wrote:

(...)

> Hi Vincent -
>
> We're replacing this code wholesale in 6.14. See:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=8233f78fbd970cbfcb9f78c719ac5a3aac4ea053

I see. Thank you for letting me know. I will then just abandon this patch.


Yours sincerely,
Vincent Mailhol

