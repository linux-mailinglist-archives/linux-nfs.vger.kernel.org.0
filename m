Return-Path: <linux-nfs+bounces-19879-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLOlHyfArmlEIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19879-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 13:42:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD223902E
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 13:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 697A13037E67
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE33AA1B1;
	Mon,  9 Mar 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMiTsNtD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X93LxF1H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0C1E8342
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059975; cv=pass; b=RBItZRt3YYcV6kSFtXnnYPHrbIMHWCy6WARDDbhGrug0CXNa1VFUexr8tXCnjDgmJlmGxJdaPJKQs8mrVVHxKOpCr3VgP0kswXuTJOV3RThLmGMZ0qGiUA46oKw1DHZPzzhD8MA4/mSzBhhFAeiBwM2rlAt2QIqSP8TLpHpciHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059975; c=relaxed/simple;
	bh=rgRlDj9b41vkbE0h1Nwql9mdXi9VVN2Tzr0kA1NWsvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENIBZzI9Sl7mjD/NfiAesSPfmLHmRNTnVIjiBygRt8lUd7O0FvjYJlIfaqezeNALu9VkPsbCTakuevUDwwyPJkuQDqGpjXs4Hrn52FDoJAEZ0qFW4je+MKm0EHvmO9qy+630XiN3U4LgdPRxWnLkWTP5dM9BatblBFRv0+2rFO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMiTsNtD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X93LxF1H; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773059973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRvbfBHWm3CSFW5500q2eLhQpohiSPTg5LuTGkQjWyE=;
	b=CMiTsNtD865EB8Yiy4hB6HKIicEcuhf8kVYoANXoW2sPiCgZNb6v+gBsBIPsfHUygtCTV0
	yLVBNtI4j+N1Jhl5ayO44yxKsstaiPd69SLZ+EsvnbNxJPWV9r/Ur7jmDgfYmd+MnXK7uC
	uxPvyN8ufzzHBxHz1ISLT2loXSzDyKY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-Io2DPlA1NhSRFWtZgSoYdQ-1; Mon, 09 Mar 2026 08:39:32 -0400
X-MC-Unique: Io2DPlA1NhSRFWtZgSoYdQ-1
X-Mimecast-MFC-AGG-ID: Io2DPlA1NhSRFWtZgSoYdQ_1773059971
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38a4102eff6so12749821fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 05:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773059969; cv=none;
        d=google.com; s=arc-20240605;
        b=NOFMst0+rxo0Rr4WycF3UPuxzMdtW97msmCL3bgHDEH5xmSRZoefvN3jVpi2l7CizF
         PsOfI6zaa6msPmdJqiX9naI+lZkP9+XF2LTrig2ifQ1dT0dxvM1cm0aJlVNeAoHomn4u
         QwE3g3j/+w5+vwIo6Wms8ocQ76oID6DcurDPuHTFFvUeJ/Fnai8MeUrnwvmTAjuFve4g
         rKP1h/jBFMlS8GtXW4JTfoJ6zDdhv++0dq4B2PZSkC/0Ku8hHB7533oYC2bPi0EMEG7f
         SMLAVIcfClulAPBDhwL+/W5XtLMo/59kvhb8uCkSA1979duFnn2otem6rXM4c4DvJeA4
         SKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRvbfBHWm3CSFW5500q2eLhQpohiSPTg5LuTGkQjWyE=;
        fh=BrJIAqdRy0WuwapEwKcT75zab3jRW+0DBRAZ9mZw3L8=;
        b=OD/vl38wALaB9SCWoR4FbXqg/dne4j2z4IWZUj4Eepy0bMUohoLwcxO1JUhhXZtJBe
         1k6uAAs+1Gz0tyoZMrbytr682DZy3wLVrnAVym8zFWKKtKQSFrkOUOBMf3HHk8Jc8Ppg
         9Z78zQFQMMb0d0QIUXXwY1PcnQxClvKSbHRESNJuj8kqm2XenHHcRI1lBDlhymhfikJt
         DYWuYsNjgjAClAKrRwMWiq+3hceLx0yixIl/mhQMkSPxAK+pk5McKpWDYaA8fBOECCS+
         G1TEJt8JBWmlHXvKkQO3M7SqBjNvOVVMo/Y4dSIxgyIC+/p4NwjV8U3LYt2YwKu+OAGJ
         S5Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773059969; x=1773664769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRvbfBHWm3CSFW5500q2eLhQpohiSPTg5LuTGkQjWyE=;
        b=X93LxF1HhTB/PgqazulP7G4pMCkZ8rxqicZslX2bjaCTMWLAGfxJOpqEPTAzeNcHy9
         Qu3+bEgIoP+dnD7BSKxg5HMc/EeaqgaV/edW3XZ30X9evI3KRnB5b0ixZfhsX+3SkEEy
         0Z/yiYDqa0XUOhIE2/wCII4o5KOMCSprMl8ly3UWr3yWwWjIXTcAW9mZZ3WajLe4fjfr
         UTHIxr0CzcbDpCsxqBIoOr7wEz09nmec+yMByPPqzuY05qBBWYCbzhaKBHmxIx9rXS3j
         enLoae/IVPhIMoVJD6i4FHyF6Lvzlqhd2EiMViVPRx5aGfteYtubrCO4jQdqWbfuOGyX
         ppCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773059969; x=1773664769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRvbfBHWm3CSFW5500q2eLhQpohiSPTg5LuTGkQjWyE=;
        b=M7EUE8LxjowV2QNnyTO4pZQdfHUSNJ96zPLBTovI0Z2Eh27Y8QzYv0ZMRrV2Dv1B3b
         9H6HVSZ8kBWuR3XmXimpHbGBaVAWBiD461rjaFzoXejonA4M6xQQxYGOk8OQ/3K9Ebd3
         on2MSNNfAuW6X4ljDQTn5jcEi7z2NTVl0jYGLxydcDyRIFezVW6/Y3FEwLzazSLbjTHY
         DfJT7Iz0KUv3iiUCqo/LjfM+Xq41zsVjzLYe0+8ZIkAknJSeZGucHrcM75JW4ZA3x4ZL
         QyqRW6FZa1+K/9Qn0zn+G5e/R/lSaGmOjhd0yzNxQW8tevWc4syW5ZEZEColxoEXtbTo
         A7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3X1d4/3NrjW7l471/ZVDqYCmoz1ZlxYoTUUxAGQf4+9ie295yHv5dkHhPhYivpQ0RtlHnUG9dn10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQVRZQNxut2qVKoicuSst6IY1E1xT1owfxJJZaZNdqmuhV8M4
	MQ9CsRv/Nigt9J7iSQZiJo5EFYrb/MrJtw39sSePmXzflJymPp5CuCTBUiJlVRMfEs5EHxZEHup
	R2F9gvs5ITArp7ISlivF8tZ2r87azedlXNqbaBDRjo83z1cdSCs+Go7ykV+mp8DIT0lc/ZvguO5
	b98J9mStB9G3oNGwuKRjgE9Z7NhVOSNZLUT6BVcLO19pLIi8DN3Q==
X-Gm-Gg: ATEYQzzOBWLiD8AUac86vGPFWUMzw4rFb0s5mhodSitM0gDo5nUVKUWgUTCWpna8rb+
	THFGlHdV5EzQTracQstJcfLRZo4fXkfKA7g5onwjDl8AE36bd4IhZohOnXlfnpAGLxx67uJdd/a
	bJQzaQXqpf7NBZGwt1aXBbaXdKU+hCSM8n4XXnu1W/h0LlHGyIF6dn8YBWvj9UVCJfRW/SYvcgD
	q9vmbhzAAFRYOzXLmkXRZm8A+lBv6pAdOSxzjkNPgmkm0LRUM8=
X-Received: by 2002:a05:651c:41dc:b0:38a:27e:b916 with SMTP id 38308e7fff4ca-38a40b3dbc8mr31090101fa.4.1773059969194;
        Mon, 09 Mar 2026 05:39:29 -0700 (PDT)
X-Received: by 2002:a05:651c:41dc:b0:38a:27e:b916 with SMTP id
 38308e7fff4ca-38a40b3dbc8mr31089911fa.4.1773059968649; Mon, 09 Mar 2026
 05:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306161929.4148128-1-atomlin@atomlin.com> <ea495f1d-1464-4f9d-91de-dd3fe828fcff@redhat.com>
In-Reply-To: <ea495f1d-1464-4f9d-91de-dd3fe828fcff@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 9 Mar 2026 20:38:54 +0800
X-Gm-Features: AaiRm50OID_tCpXBE6oJdUqPXjtWamzHEdCb__JO83rj9UgifnbeCu9Oe-hFDiA
Message-ID: <CAHj4cs-Eg7sJZLju_32yiQv5x=WHvVUpkgFshzr2AQZek+z1=Q@mail.gmail.com>
Subject: Re: [PATCH] nfsrahead: enable event-driven mountinfo monitoring and
 skip non-NFS devices
To: Steve Dickson <steved@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: tbecker@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C3FD223902E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-19879-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.976];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Steve/Aaron
The patch seems still have issues. Here is the journal log during blktests:

# rpm -qf /usr/libexec/nfsrahead
nfs-common-utils-2.8.6-0.fc44.x86_64

Mar 09 08:35:05 (udev-worker)[9120]: 8:16: Process
'/usr/libexec/nfsrahead 8:16' terminated by signal ABRT.
Mar 09 08:35:05 (udev-worker)[9120]: 8:16: Failed to wait for spawned
command '/usr/libexec/nfsrahead 8:16': Input/output error
Mar 09 08:35:05 (udev-worker)[9120]: 8:16:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Failed to execute "/usr/libexec/nfsrahead 8:16": Input/output
error
Mar 09 08:35:07 systemd-coredump[9148]: Process 9146 (nfsrahead) of
user 0 dumped core.

                                        Module /usr/libexec/nfsrahead
from rpm nfs-utils-2.8.6-0.fc44.x86_64
                                        Module
/usr/lib64/ld-linux-x86-64.so.2 from rpm glibc-2.43.9000-2.fc45.x86_64
                                        Module libpcre2-8.so.0 from
rpm pcre2-10.47-1.fc44.1.x86_64
                                        Module libselinux.so.1 from
rpm libselinux-3.10-1.fc44.x86_64
                                        Module libblkid.so.1 from rpm
util-linux-2.41.3-12.fc44.x86_64
                                        Module libc.so.6 from rpm
glibc-2.43.9000-2.fc45.x86_64
                                        Module libmount.so.1 from rpm
util-linux-2.41.3-12.fc44.x86_64
                                        Stack trace of thread 9146:
                                        #0  0x00007f7a2fdd89cc
__pthread_kill_implementation (libc.so.6 + 0x759cc)
                                        #1  0x00007f7a2fd7d34e raise
(libc.so.6 + 0x1a34e)
                                        #2  0x00007f7a2fd647b3 abort
(libc.so.6 + 0x17b3)
                                        #3  0x00007f7a2fd65804
__libc_message_impl.cold (libc.so.6 + 0x2804)
                                        #4  0x00007f7a2fde2d2c
malloc_printerr (libc.so.6 + 0x7fd2c)
                                        #5  0x00007f7a2fde4710
_int_free_merge_chunk (libc.so.6 + 0x81710)
                                        #6  0x00007f7a2fde4789
_int_free_chunk (libc.so.6 + 0x81789)
                                        #7  0x000056327361bd47 main
(/usr/libexec/nfsrahead + 0xd47)
                                        #8  0x00007f7a2fd66681
__libc_start_call_main (libc.so.6 + 0x3681)
                                        #9  0x00007f7a2fd66798
__libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x3798)
                                        #10 0x000056327361bfc5 _start
(/usr/libexec/nfsrahead + 0xfc5)
                                        ELF object binary
architecture: AMD x86-64
Mar 09 08:35:07 (udev-worker)[9115]: 8:16: Process
'/usr/libexec/nfsrahead 8:16' terminated by signal ABRT.
Mar 09 08:35:07 (udev-worker)[9115]: 8:16: Failed to wait for spawned
command '/usr/libexec/nfsrahead 8:16': Input/output error
Mar 09 08:35:07 (udev-worker)[9115]: 8:16:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Failed to execute "/usr/libexec/nfsrahead 8:16": Input/output
error



On Sat, Mar 7, 2026 at 6:10=E2=80=AFAM Steve Dickson <steved@redhat.com> wr=
ote:
>
>
>
> On 3/6/26 11:19 AM, Aaron Tomlin wrote:
> > The nfsrahead utility relies on parsing "/proc/self/mountinfo" to
> > correlate a device number with a specific NFS mount point. However, due
> > to the asynchronous nature of system initialisation, the relevant entry
> > in mountinfo may not be immediately available when the tool is executed=
.
> >
> > Currently, the utility employs a naive polling mechanism, retrying the
> > search five times with a fixed 50ms delay (totalling 250ms). This
> > approach proves brittle on systems under heavy load or during
> > distinctively slow boot sequences.
> >
> > To mitigate this race condition and improve robustness, update
> > get_device_info() to utilise the libmount monitoring API.
> >
> > The new implementation introduces the following logic:
> >
> >      1.  Initialises a monitor on /proc/self/mountinfo using
> >          mnt_new_monitor().
> >
> >      2.  Replaces the fixed polling loop with mnt_monitor_wait().
> >
> >      3.  Increases the maximum wait time to 10 seconds (MNT_NM_TIMEOUT)=
.
> >
> >      4.  Introduces a fast-path rejection mechanism. NFS backing device=
s are
> >          allocated from the kernel's unnamed block device pool (major n=
umber
> >          0). While some local multi-device filesystems (such as Btrfs) =
also
> >          utilise anonymous device numbers, physical hardware block devi=
ces
> >          (e.g., sda, nvme) always possess specific, non-zero major numb=
ers.
> >          By instantly exiting with -ENODEV for any device string not
> >          beginning with "0:", we safely bypass the monitor for physical
> >          drives, preventing the exhaustion of udev worker threads.
> >          See set_anon_super() and get_anon_bdev().
> >
> >      5.  Implements strict monotonic deadline tracking within the monit=
or
> >          loop to prevent indefinite blocking.
> >
> > Fixes: 2b62ac4c ("nfsrahead: enable event-driven mountinfo monitoring")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Link: https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOa=
MiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> Committed... (tag: nfs-utils-2-8-6-rc4)
>
> steved.
> > ---
> >
> > Hi Steve,
> >
> > This patch should resolve the udev worker exhaustion issue reported by
> > Yi. It applies cleanly on top of the current nfs-utils tree, after your
> > revert [1].
> >
> > Thank you.
> >
> > [1]: https://lore.kernel.org/linux-nfs/20260305124221.55407-1-steved@re=
dhat.com/
> >
> >
> >   tools/nfsrahead/main.c | 55 +++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 54 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> > index b7b889ff..78cd2581 100644
> > --- a/tools/nfsrahead/main.c
> > +++ b/tools/nfsrahead/main.c
> > @@ -3,6 +3,7 @@
> >   #include <stdlib.h>
> >   #include <errno.h>
> >   #include <unistd.h>
> > +#include <time.h>
> >
> >   #include <libmount/libmount.h>
> >   #include <sys/sysmacros.h>
> > @@ -17,6 +18,8 @@
> >   #define CONF_NAME "nfsrahead"
> >   #define NFS_DEFAULT_READAHEAD 128
> >
> > +#define MNT_NM_TIMEOUT 10000
> > +
> >   /* Device information from the system */
> >   struct device_info {
> >       char *device_number;
> > @@ -117,7 +120,57 @@ out_free_device_info:
> >
> >   static int get_device_info(const char *device_number, struct device_i=
nfo *device_info)
> >   {
> > -     int ret =3D get_mountinfo(device_number, device_info, MOUNTINFO_P=
ATH);
> > +     int ret;
> > +     struct libmnt_monitor *mn =3D NULL;
> > +     struct timespec start, now;
> > +     int remaining_ms =3D MNT_NM_TIMEOUT;
> > +
> > +     /*
> > +      * Fast-path rejection:
> > +      * NFS backing devices always use the anonymous block device majo=
r number (0).
> > +      * If the device number does not start with "0:", it is a physica=
l block device
> > +      * and will never be an NFS mount. Exit immediately to prevent bl=
ocking udev.
> > +      */
> > +     if (strncmp(device_number, "0:", 2) !=3D 0)
> > +             return -ENODEV;
> > +
> > +     ret =3D get_mountinfo(device_number, device_info, MOUNTINFO_PATH)=
;
> > +     if (ret =3D=3D 0)
> > +             return 0;
> > +
> > +     mn =3D mnt_new_monitor();
> > +     if (!mn)
> > +             goto fallback;
> > +
> > +     if (mnt_monitor_enable_kernel(mn, 1) < 0) {
> > +             mnt_unref_monitor(mn);
> > +             goto fallback;
> > +     }
> > +
> > +     clock_gettime(CLOCK_MONOTONIC, &start);
> > +
> > +     while (remaining_ms > 0) {
> > +             int rc =3D mnt_monitor_wait(mn, remaining_ms);
> > +             if (rc > 0) {
> > +                     ret =3D get_mountinfo(device_number, device_info,=
 MOUNTINFO_PATH);
> > +                     if (ret =3D=3D 0) {
> > +                             mnt_unref_monitor(mn);
> > +                             return 0;
> > +                     }
> > +             } else {
> > +                     break;
> > +             }
> > +
> > +             clock_gettime(CLOCK_MONOTONIC, &now);
> > +             long elapsed_ms =3D (now.tv_sec - start.tv_sec) * 1000 +
> > +                               (now.tv_nsec - start.tv_nsec) / 1000000=
;
> > +             remaining_ms =3D MNT_NM_TIMEOUT - elapsed_ms;
> > +     }
> > +
> > +     mnt_unref_monitor(mn);
> > +     return ret;
> > +
> > +fallback:
> >       for (int retry_count =3D 0; retry_count < 5 && ret !=3D 0; retry_=
count++) {
> >               usleep(50000);
> >               ret =3D get_mountinfo(device_number, device_info, MOUNTIN=
FO_PATH);
>


--=20
Best Regards,
  Yi Zhang


