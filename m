Return-Path: <linux-nfs+bounces-9014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D14DA07770
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC03E7A14B7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C85218E9C;
	Thu,  9 Jan 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bufTHYIw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD121B907
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429367; cv=none; b=JV8VX0i52HAEO2Lmz7iJ2nGXoXm/6QzWe/vxKCTHu3XI0tbbRKi7f7rwFfDz/MM4bgbuCknraI59lR5SRAoNbJUOapmpaGWR+qGfz+R+ug9g8VUNzNUseBQRjwe5mvP6iv1YhbiyskfLBiY+yL+mKo9vjDmIX+erQ05W4csztx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429367; c=relaxed/simple;
	bh=4ZvnxXfPl0MpnD1fwgU+7xgn5vHkJOeHXLK49b5QKvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaEbM0JxFpjFxkM2ZIhZP9M+FTfOZdtCkGAC2UXL/XKEMillDWRnVaMZ5+d1W3Yh7ylsU6LnysXJh5pJS1TQSZGnvjvgoi5e1QEzYfwCmxUd3tAfU3tVToVwFcJAUye6igTHhsm7kWOhTFcyJwy05F5HQKAaeCwsbr6o3PO4URU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bufTHYIw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385df53e559so720028f8f.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736429363; x=1737034163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hiqvfR1VWlp31fOYATG9sWIYmzfBhGfTQv6mGUvG9+k=;
        b=bufTHYIwZ8Pv8Qot3q6Ag5v1OOSDtiWUUHUZl1tUlZYkrbjJDiIkRZD3yEZOEhiEO1
         hYuOSLWHfl7pecawX7nTDucxVgNgoYc30DPSZjHLk20amrxvx7oflfdeL6WUXeOCibxJ
         F+TSES84JFhwbmCxrXbUxuV3oWm4gHhrEGJVIRnrO0+6SJfEwvNjUHeges43v1SpiD1W
         J0gnO/4gUfVoY3vr543EKSdtDVy+DjK71HDu0RuntDw7s/mfH8AzspQzwx1+e6cSfm6C
         RGAeQpCOA9z1Km/G2gezzpIWJ3fZ0tkIYme37BFNGFaKB7+mFOgJ/YB4akgh276L8OKZ
         0g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736429363; x=1737034163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiqvfR1VWlp31fOYATG9sWIYmzfBhGfTQv6mGUvG9+k=;
        b=RsHA9vycBm5Tf5RrTkOinrfIiwg3M7eGVrvELOhU1EWXEu0ZxaV91X/a1BEv0QJwG0
         U/gp+NfvPC7+ivWBs4YoJzl10iryqBC66I5+EVCktl0O5dXkrJRLZNkoTs8j4xe+1TX6
         NXgJrelfue9qSFaSBHs2D3mlqWuRaebWIC72saEkBEoFf1a+b63QTSHUA6jrrcmPmzg5
         r8MVoSrV7hcZj1o3w7PhX0PVzx5cLRWYObr8lqENE3fRCT/hOS4yn1wLo+9zJQTU01Zb
         AdHLNOA/Bi4FXPZNycoIvLMp7/1vhlZ7UmeKaB1UzQ5UpU/V33THS5QN0KLNI/JYi99q
         ZPqg==
X-Forwarded-Encrypted: i=1; AJvYcCWd5jVAHuSXxw0PyN2R7mi9y7pxl0yTaNAqubK18St+tRVY466ImDUUeUlhFc4kxertF8z071L7a5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mGZ8KDw1+w6nNWMS6hP+ezlsgGAIO2DrvkQ3mPVrXbcLNW8M
	xFQejpbzVsbfBsSTE/LppK30R5v5XvgPLacpOqZZSHwSWONrhM6/qkbxEw==
X-Gm-Gg: ASbGncvtn/QNtoMQc7vwMk1GyJs+Dmkp7q45NDEwIC+1PfTCg7ABCK1HnA4+9YmMzOI
	HmhC6JK8Er69qU9Y3bwcvvSLVp6uEL6qyQundijuc+xP1zlx8dkUQhUrp7MR+2bX/bxZbEkQWru
	A0mh3Eh/WjjB/6/KJZ6if1YyzXLIf4UzFacyxo7048YLoOtyg81COoFox6GwV91r7fAwIKjdthJ
	fuIBIi2mIwGdsB1hq5imTpi3ANvDGnR9EKyvWaw0jWqL/CRfmPr1aLKtRWZUYwxe1OeEbY1kgg8
	Y5n5ja1x7Fn4Wkg2sGrlY5YbFznE9yVGAJ2G
X-Google-Smtp-Source: AGHT+IEbhcBsKUN1DhbHzls7EYcyv6vX8HvdZF3258POq3LbVzq36R5uHhSs/70B6sqIua/TsgDYoA==
X-Received: by 2002:a05:6000:2a3:b0:385:efc7:932d with SMTP id ffacd0b85a97d-38a8730faafmr5885221f8f.46.1736429363296;
        Thu, 09 Jan 2025 05:29:23 -0800 (PST)
Received: from [192.168.1.31] (86-44-211-146-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.44.211.146])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1d13sm1848010f8f.91.2025.01.09.05.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:29:22 -0800 (PST)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <301468bd-7b9f-48c5-8670-48379b437931@draigBrady.com>
Date: Thu, 9 Jan 2025 13:29:22 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: bug#74692: ls -la unexpected output on NFS shares, possibly due
 to listxattr in gnulib
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: 74692@debbugs.gnu.org,
 Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
 linux-nfs@vger.kernel.org
References: <CAOLeGd3ubjfb8vKWez0zYuGMGhcET_vsns2HfoKoFK-rStc4SQ@mail.gmail.com>
 <0296d983-8fa3-4ea4-9d77-44c18f91dbe0@cs.ucla.edu>
 <2faafa4a-0eda-4430-a852-a4f7879c23d7@draigBrady.com>
 <081f4f6c-827b-4e45-97d6-87b197460900@cs.ucla.edu>
 <70757094-d4ff-4414-aa8b-557e0227d70b@draigBrady.com>
 <0a479f97-9bf2-4c31-8f73-8692fcabfb49@cs.ucla.edu>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
In-Reply-To: <0a479f97-9bf2-4c31-8f73-8692fcabfb49@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've CC'd linux-nfs in case anyone there has some insight
as to why listxattr() is more restrictive on NFS than locally,
returning EACCES for files without read access. Details below...

On 09/01/2025 04:55, Paul Eggert wrote:
> Thanks, but is this part of the change needed?
> 
>> +  else if (f->acl_type == ACL_T_UNKNOWN)
>> +    modebuf[10] = '?';
> 
> I thought modebuf[10] was already '?' at that point.

Only if the stat() failed, which is not the case here.

Note it's worth mentioning that over NFS with unreadable files
you can GET the security.selinux xattr, but you can't LIST any xattrs:

   $ strace -e trace=/.*xattr.* attr -S -g selinux /mnt/nfs/file
   lgetxattr("/mnt/nfs/file", "security.selinux", "system_u:object_r:nfs_t:s0", 65536) = 27
   Attribute "selinux" had a 27 byte value for /mnt/nfs/file:
   system_u:object_r:nfs_t:s0
   +++ exited with 0 +++

   $ strace -e trace=/.*xattr.* attr -S -l /mnt/nfs/file
   llistxattr("/mnt/nfs/file", 0x7ffc92de48a0, 65536) = -1 EACCES (Permission denied)
   attr_list: Permission denied
   Could not list /mnt/nfs/file

Also there was a change since coreutils v9.5 where we don't call the GET,
whereas coreutils 9.5 did call lgetxattr() and thus showed the correct (.) flag
(albeit with the problematic warning):

   $ strace -e trace=/.*xattr.* src/ls -l /mnt/nfs/file
   llistxattr("/mnt/nfs/file", 0x7ffe1e5b7b6c, 152) = -1 EACCES (Permission denied)
   --w-------? 1 padraig padraig 0 Jan  8 20:42 /mnt/nfs/file
   +++ exited with 0 +++

   $ strace -e trace=/.*xattr.* ls-v9.5 -l /mnt/nfs/file
   lgetxattr("/mnt/nfs/file", "security.selinux", "system_u:object_r:nfs_t:s0", 255) = 27
   listxattr("/mnt/nfs/file", 0x7ffd58023810, 152) = -1 EACCES (Permission denied)
   ls: /mnt/nfs/file: Permission denied
   --w-------. 1 padraig padraig 0 Jan  8 20:42 /mnt/nfs/file
   +++ exited with 0 +++

So perhaps we should also always call lgetxattr("security.selinux"),
or at least fall back to that upon EACCES from listxattr() ?

cheers,
Pádraig

