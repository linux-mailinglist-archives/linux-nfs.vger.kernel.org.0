Return-Path: <linux-nfs+bounces-11767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F161AB9B69
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE89E7F6B
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9623182A;
	Fri, 16 May 2025 11:46:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834A22259B;
	Fri, 16 May 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396018; cv=none; b=DtFM6ZlkvYeP761A9tQLZuk/nvLCO0jT4bPbQsu6HPKv7Ax6A9AZdvTPYIW/oUtAgrnqWhCBeJPjdHY2qCWfg+VthbXDtYg5oCXwd9hAhv6HtE5WYBtjfoMLOzVdptoNlBZANsYHgJiGyusyYohFKLEgK+Yez6XjgmLeUQ/dKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396018; c=relaxed/simple;
	bh=P2MGul/iONu8XqlMpG0+0M3tANrl0DU+W8I8PXkQdhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqz/GD11qMAp9tY9bHUFEUD+IK1tALvFLGOc3oG+ZuQKBulFy9ZF+HuMlDda/97GdHfR/LRoZtf0UEpNPCD5IWnCUD1WjmBeZmx1wQDerhCjjnhcahbulbAF+2YvRNNUgj1pnTzuejiQPHn8lJ8TLm65wMQIZ+XRNLI+35q74o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so15400635e9.1;
        Fri, 16 May 2025 04:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747396015; x=1748000815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2MGul/iONu8XqlMpG0+0M3tANrl0DU+W8I8PXkQdhk=;
        b=hzoP/QxtOt6PUHvinnvC3NWuPO2MNMYWPqbUcsil87qGovvYmFcF+yXcY6URsauNgV
         sqQii0AId4IZcmnIsFNWhNsFa4lgnptqOczk/wYBzp1+rlOYa9V40FzsaaRLpmAUzITH
         MosRXe4dii0OZmk8iv9IScgIOtmpeWwSp9pkEaRNLWYDwnbI/5qNsQQumOCxB+/OQ9J3
         yqyMRvxiIGDTKVeh6x06gymBjNir7QFFyFx8lkrT9O5Ifc68/HFuYpZtPR6vAzHpmGdM
         9LrC0SscV4Y5/sxMFIcxD1dpDEwC/rFiZkpjUKQhni7SLIVnA/GLXh9Y0AwFYHmkkGJE
         42Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWmV/0H9B2gK1BwMXRmnQLe3BvMjTuJlX4bB2eN8z89ysV2aIIxzPrlwj/APUFmnbsymZGBbzTHDvQ/@vger.kernel.org, AJvYcCX3W/7kJVY3FierQqnh4niClBsWXXvY8hBQAxd2R8exDyvyS5VeY9Z7fLsbSfrpx0Nb3N0PmWqONA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCAI4jkybRBVVp+DM5/5+Q1CNsMVHsyl7WSJG29xDt3yUWcWt
	h3Yu+e0BWqDEK/x7hhYKYBUupZEoEydFPl8BLKyxMEA3PDc2L9Ev7G83
X-Gm-Gg: ASbGnctT2mYWHQO9hnppoSQsrvcV3DerMS9pc3VP6I3VR/0t6CscHQUHGYYetIcdDLL
	lsnsOEpxzv52PQAXlTSVmiKeV4IU0nC7xTOz2pQCkCZ0mPVFTLGCJyK7IT15cfOfbVz8ATZU4f3
	lP7Btsus8WCTWI/UtjzmOIsS1fjVigbxy5AzjyoUxQ2SrDbVDi9Bl5wPL5EN1ys+STVALdUMkKU
	NhDZwes4IOzW+NdO2Ujq9Eam8LoPvRZr6KZmnZtuqSFtT5U7xm+hQP8IlUxX0xs3SP65XbK5IG3
	Duh4vISTWjbn1xExL6gVCqwPfVoLbcbBxX4vGnh+MyLOHJKs3P4fNzOBEL5eVaVaTcJMaulyHJ7
	r2yIb1+OncAW7C67ncIE=
X-Google-Smtp-Source: AGHT+IH34fqER+F0gFms0Y7uwq6fzlTdeCwf77MrGQZyzyo8gUXRuxXFo6iB46ssNsnpb9tTo71Uuw==
X-Received: by 2002:a05:6000:402b:b0:3a0:b7ee:b1c3 with SMTP id ffacd0b85a97d-3a35c821fe2mr2924299f8f.6.1747396014536;
        Fri, 16 May 2025 04:46:54 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a361b04236sm1628786f8f.28.2025.05.16.04.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 04:46:54 -0700 (PDT)
Message-ID: <872403b5-c6b4-4c4b-bff5-8e60b22f8102@grimberg.me>
Date: Fri, 16 May 2025 14:46:52 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support keyrings for NFS TLS mounts v2
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250515115107.33052-1-hch@lst.de>
 <79477eac-ba92-4d2a-9905-f5250e7e95bc@oracle.com>
 <20250516051630.GA13495@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250516051630.GA13495@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/05/2025 8:16, Christoph Hellwig wrote:
> On Thu, May 15, 2025 at 08:31:23AM -0400, Chuck Lever wrote:
>>> Note that for now the .nfs keyring still needs to be added to
>>> tlshd.conf, but that should go away with the handshake enhacement
>>> from Hannes.
>> Just curious: Is there a downside to shipping a default /etc/tlshd.conf
>> with the NVMe and NFS keyrings already added?
> That's probably a good idea for the current situation, but doesn't
> resolve solve the overall problem of having to add every new service
> there.

IIRC Hannes told me that latest tlshd already does this for .nvme keyring

