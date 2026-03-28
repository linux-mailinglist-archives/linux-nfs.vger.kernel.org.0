Return-Path: <linux-nfs+bounces-20486-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNsuBYxux2mXXQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20486-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 07:00:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2034D75F
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 07:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E774230219EE
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 05:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972F2DCF41;
	Sat, 28 Mar 2026 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZsULkG6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uI1FsAVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E41C862D
	for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774677262; cv=pass; b=qX4bEYVg6Uqa5HdM4VrA9266umjIFimaJiuUVocNK5tj8KRprWqLmRTeofcVmR8djbt/P4ifnaUlIATnvxmbzCK46UgELKgecfhibI94JoqXXrS3Kizi2wIPpCbKYw5/mkMZ51VZJycB5fogfcxjgUa6FqloCps8+hAPT7Lh1ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774677262; c=relaxed/simple;
	bh=EpR/IkaNNQkew2Pin+BmCni90EExvfazyu4y2lWBWi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOM/PDTnj3bos9T0KOr0xPjT8Jwtr5POdXuJjBVq6eBXBI/yRWL6QdAokr+1xEX3pqsZA3QhMtdO2xYxJQOm2G3SVQPFo9crwGgHVAVwuYr1dfsGbLESs08zVK2zEN7i2Nko2w1S/3ULpHs1Kojz/55VFs+q75rcpgzvXJH17/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZsULkG6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uI1FsAVD; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774677258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ral+0yXnWLvpGLkoeq1/cNkxiw9iBEHexNm7Gje0e98=;
	b=YZsULkG67bkyB3cHW4eLbnnwNpkXiVLdC5AEnhDLbbYUEnDUFZK79DDq8GhGZm4eTkNJlW
	Y/VmoEERRisEV1KzWORWp+IiPwNOVLbDm8CJ007cZ0vwfNzQeOueuKU2XnxG3sQMNBQBXn
	jTAr8JowA6vuUc4ng2y+SBb8WZq044A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-9BF4fljmP9aWPY0DWVlskg-1; Sat, 28 Mar 2026 01:54:16 -0400
X-MC-Unique: 9BF4fljmP9aWPY0DWVlskg-1
X-Mimecast-MFC-AGG-ID: 9BF4fljmP9aWPY0DWVlskg_1774677256
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89ed6f0c71aso1217316d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 22:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774677256; cv=none;
        d=google.com; s=arc-20240605;
        b=TZjE9p7rp1hcDkfI/GlijYOKreXdWwe+VnkfDflo3zB4ppdYeqqJ05fbFgBCu7OCvz
         E4yOC4T35vE4o9tC4UnVdLmkQ3y8dXXcM9LXhPRxXqw5L7ylY9e6ANmlc+9h1u9layab
         vllQMHnuy6NH4q//tI0MyPD+0zzqmsjuGDE/kTOJfUe9VB9Dc6YD3opJCLmJPL2pL3SW
         hSVo5iGAHNMjmG9pKoY/vogLKYVbOioB/eEQVvPJTc82TKxp3KFVZjPN4szlM+cjzXED
         P6b12b866ULUNDDSrrQicJsZCCx8jRmpE5PQG/dwBmj6ScE8GarInEUC8u0o1x6zyYvT
         AoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ral+0yXnWLvpGLkoeq1/cNkxiw9iBEHexNm7Gje0e98=;
        fh=tzgRj0x1ZTzfNzQOFcpAj/8/NVnJJUSnxP7n9W3indU=;
        b=Oo2nxDUBlVVMvqhWJqIGdY0j0m3EVnGFLBQInCiniJ3a6qtFNbfmk9XY/oLhWkHzcJ
         4YQGdk2K/sGHztH/EODiqkYUZ6vcPVoicgptpvxOtvQdsiD4Ei4KAfHdWvI4Sm16IzMb
         NzQysvsBw+61POtl2MDaa1dJg9a1YaxKSvu9oaHs2kGR0XXFxM/ShzazTBp8ryVFherb
         fR0O6CJb80FsLFHSyP5Li4ukOmBveMjIu0PwDgDSsz5a+CwtSxxkV17W/MFIFet9kKXf
         Hx0bl8OAbcrc+cxfZ0fSBLQXHWSNvd5AgxLb/2sJYI/crODLWHkG6c/GcHoXaH48qC2h
         8KnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774677256; x=1775282056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ral+0yXnWLvpGLkoeq1/cNkxiw9iBEHexNm7Gje0e98=;
        b=uI1FsAVDsbOM+jUt99Gbpi5AQDc1tDptGGXgm8Qw6V07znGoHi/pi+v7LUearwbqhb
         pimTEZ4hLVS3zBbE1Wi581iOGVnaDD3I4j45V+y4FeKYFDuv56Qo6Fj2A1215TWyFMy1
         xlB7IlE3qRVZbKHgru9T/wZo2eG1YhjSVnqLG/9qfdcOw8HxhTWOyRnnVwLhStWLzbc8
         Sd2FvOMAoqdlVDU9ZG/dSl58I5F206BflsmA8fQxOlhdYwyA7lPija+Y60wS5et2cg9K
         bSKDZGVGY8aMJwV1lyDf2IIsc3jqJGh6C9e/Y5cERSJqI9MF1fWbmpAvuqRrnXtR9+Pd
         epGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774677256; x=1775282056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ral+0yXnWLvpGLkoeq1/cNkxiw9iBEHexNm7Gje0e98=;
        b=EByaWDCkGWyx+wAv3K6+qF3ByJl6gJI20GaoQA/YpFGqK0b2+LRuLAi8mlbRHpCCba
         yIPV6qSaRJViIwYrEBxHd6VjZlkvFVSiyXflSAiZ1oMsqkq/UteynmI+HjIf+yCJ9yAz
         OaspHFym6uPYC0ra/esA8y1c/rLXlFP00ZNGWC/xWuQ0XmbOaTX5Rh+p29TxvMnGTPTf
         QucdIiHJnFc9fElA1pYNN3FM2N7DXoaKpeFJRWlwP61/bHI+LdWfbSZxfXe3qG5Ef5S0
         AYK8F3AkI6MYbvNCyoanzwnPBYcCNgwio+O/IIXmBPpQodvWfGH+uPQMMhiJzg6hdJje
         bQ8w==
X-Gm-Message-State: AOJu0Yyu8VsGATX4bL01tzM2m2527Y5ZngR0e1FrTqQtzNkCl/KHXcDa
	zy1B7MgX5tRKIj856tcnWnTlseQgrvS2SELyPXqyame5cr/VdrAaUn+a7WqPIHv0bs0kVXb/11s
	cm0GAdEuTFL633UnDHFN0RHv7qnd6bRrJu89DN3TdvHEluv4u2FaynP2KSCuZYX2vqBBidjwkvK
	bISLNESy/A4zJ4IMONphionQXwkd2V9JEvWjGVMQhQqZDjMQw=
X-Gm-Gg: ATEYQzzTgDmMlfmQSmkRvEhXikkxnYpZlHcaaxBLiKL0ZwN14jZdee3eBNH9PBgKs9n
	WB2OGyUIRD6N7D7W0rvQCx+9/fNHLlEVD+tCs/2AfJDIN4sVKTgiEidUfVdUJ8rL1rqGFqEq3xV
	1IffURCN9eKG1EqehrU08ADQ0pOYP/kqeugR/+K5H1sJur1yI6xoV80fpSKd68PZdRpM5upucMa
	or4UJCpaI6qV3Y+qBYPkxF73tmchevZk731k2Y=
X-Received: by 2002:a05:6214:c65:b0:89a:4fd5:6998 with SMTP id 6a1803df08f44-89ce8d395bdmr53108246d6.1.1774677255275;
        Fri, 27 Mar 2026 22:54:15 -0700 (PDT)
X-Received: by 2002:a05:6214:c65:b0:89a:4fd5:6998 with SMTP id
 6a1803df08f44-89ce8d395bdmr53108016d6.1.1774677254553; Fri, 27 Mar 2026
 22:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328054243.3072769-2-jiyin@redhat.com> <CAFAKQ6091kgRKp9xKmLsyRYeY33X4B-2PKQi63DgeCbNTB=JMA@mail.gmail.com>
In-Reply-To: <CAFAKQ6091kgRKp9xKmLsyRYeY33X4B-2PKQi63DgeCbNTB=JMA@mail.gmail.com>
From: Jianhong Yin <jiyin@redhat.com>
Date: Sat, 28 Mar 2026 13:54:02 +0800
X-Gm-Features: AQROBzBuS4xDj7FhRwtofauqsPWL1GTep-d_UfoKmk4_Ji_0V1icAdNwA6-DUnY
Message-ID: <CAFAKQ62GTXEs6XNyHShp56CSLh23uXzavGRTMk5M9VMSs==g9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pynfs: nfs4.1/nfs4server.py fixes
To: linux-nfs@vger.kernel.org
Cc: calum.mackay@oracle.com, jlayton@kernel.org, bcodding@redhat.com, 
	smayhew@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[root.id:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20486-lists,linux-nfs=lfdr.de];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.354];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyin@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.sh:url,root.id:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 94D2034D75F
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

test log:
'''
[root@rhel-9-latest ~]# bash test.sh
tmux-3.2a-5.el9.x86_64
no server running on /tmp/tmux-0/default
mount.nfs: timeout set for Sat Mar 28 01:43:35 2026
mount.nfs: trying text-based options
'vers=3D4.2,addr=3D127.0.0.1,clientaddr=3D127.0.0.1'
127.0.0.1:/ on /mnt/nfsmp type nfs4
(rw,relatime,vers=3D4.2,rsize=3D4096,wsize=3D4096,namlen=3D255,hard,proto=
=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D127.0.0.1,local_lock=
=3Dnone,addr=3D127.0.0.1)
nfsv4: bm0=3D0xe0180fff,bm1=3D0x80000a,bm2=3D0x0,acl=3D0x0,sessions,pnfs=3D=
not
configured,lease_time=3D60,lease_expired=3D0
nfsv4: bm0=3D0xe0180fff,bm1=3D0x4080000a,bm2=3D0x0,acl=3D0x0,sessions,pnfs=
=3DLAYOUT_NFSV4_1_FILES,lease_time=3D60,lease_expired=3D0
nfsv4: bm0=3D0x20180fff,bm1=3D0x80000a,bm2=3D0x0,acl=3D0x0,sessions,pnfs=3D=
not
configured,lease_time=3D60,lease_expired=3D0
88888
99999
[root@rhel-9-latest ~]# cat test.sh
systemctl stop nfs-server; rpm -q tmux || yum install -y tmux
nfsmp=3D/mnt/nfsmp; mkdir -p $nfsmp
umount -a -t nfs,nfs4
tmux kill-server
cd /usr/src/pynfs/nfs4.1  # nfs4.1 includes feature pnfs
echo "${IP:-127.0.0.1}:12345/pynfs_mds" >dataservers.conf
\cp -f sample_code/ds_exports.py .
tmux new -s ds -d "./nfs4server.py -r -v --is_ds --exports=3Dds_exports
--port=3D12345" \; pipe-pane "exec cat >/tmp/ds.log"
tmux new -s mds -d "./nfs4server.py -r -v --use_files
--dataservers=3Ddataservers.conf" \; pipe-pane "exec cat >/tmp/mds.log"
mount -vvv -o vers=3D4.2 ${IP:-127.0.0.1}:/ ${nfsmp}
mount -t nfs4
echo 88888 >${nfsmp}/files/testfile
echo 99999 >${nfsmp}/a/testfile
grep pnfs=3D /proc/self/mountstats
cat ${nfsmp}/files/testfile
cat ${nfsmp}/a/testfile
'''


On Sat, Mar 28, 2026 at 1:49=E2=80=AFPM Jianhong Yin <jiyin@redhat.com> wro=
te:
>
> test log:
> '''
> [root@rhel-9-latest ~]# bash test.sh
> tmux-3.2a-5.el9.x86_64
> no server running on /tmp/tmux-0/default
> mount.nfs: timeout set for Sat Mar 28 01:43:35 2026
> mount.nfs: trying text-based options 'vers=3D4.2,addr=3D127.0.0.1,clienta=
ddr=3D127.0.0.1'
> 127.0.0.1:/ on /mnt/nfsmp type nfs4 (rw,relatime,vers=3D4.2,rsize=3D4096,=
wsize=3D4096,namlen=3D255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsy=
s,clientaddr=3D127.0.0.1,local_lock=3Dnone,addr=3D127.0.0.1)
> nfsv4: bm0=3D0xe0180fff,bm1=3D0x80000a,bm2=3D0x0,acl=3D0x0,sessions,pnfs=
=3Dnot configured,lease_time=3D60,lease_expired=3D0
> nfsv4: bm0=3D0xe0180fff,bm1=3D0x4080000a,bm2=3D0x0,acl=3D0x0,sessions,pnf=
s=3DLAYOUT_NFSV4_1_FILES,lease_time=3D60,lease_expired=3D0
> nfsv4: bm0=3D0x20180fff,bm1=3D0x80000a,bm2=3D0x0,acl=3D0x0,sessions,pnfs=
=3Dnot configured,lease_time=3D60,lease_expired=3D0
> 88888
> 99999
> [root@rhel-9-latest ~]# cat test.sh
> systemctl stop nfs-server; rpm -q tmux || yum install -y tmux
> nfsmp=3D/mnt/nfsmp; mkdir -p $nfsmp
> umount -a -t nfs,nfs4
> tmux kill-server
> cd /usr/src/pynfs/nfs4.1  # nfs4.1 includes feature pnfs
> echo "${IP:-127.0.0.1}:12345/pynfs_mds" >dataservers.conf
> \cp -f sample_code/ds_exports.py .
> tmux new -s ds -d "./nfs4server.py -r -v --is_ds --exports=3Dds_exports -=
-port=3D12345" \; pipe-pane "exec cat >/tmp/ds.log"
> tmux new -s mds -d "./nfs4server.py -r -v --use_files --dataservers=3Ddat=
aservers.conf" \; pipe-pane "exec cat >/tmp/mds.log"
> mount -vvv -o vers=3D4.2 ${IP:-127.0.0.1}:/ ${nfsmp}
> mount -t nfs4
> echo 88888 >${nfsmp}/files/testfile
> echo 99999 >${nfsmp}/a/testfile
> grep pnfs=3D /proc/self/mountstats
> cat ${nfsmp}/files/testfile
> cat ${nfsmp}/a/testfile
> '''
>
> On Sat, Mar 28, 2026 at 1:43=E2=80=AFPM Jianhong Yin <jiyin@redhat.com> w=
rote:
>>
>> From: Scott Mayhew <smayhew@redhat.com>
>>
>> Most of the strings in pynfs are not str but rather "bytes" objects.
>> - fixed default string type
>>   - "string" -> b"string"
>>   - .encode("utf-8")
>>   - StringIO -> BytesIO
>>   - etc
>> - nfsstat4 -> const4.nfsstat4
>> - python3: fixed syntax of Exception process code
>> - python3: d.itervalues() -> d.values()
>>
>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>> ---
>>  nfs4.1/config.py                 | 20 ++++----
>>  nfs4.1/dataserver.py             | 32 ++++++-------
>>  nfs4.1/fs.py                     | 52 +++++++++++---------
>>  nfs4.1/nfs4client.py             |  4 +-
>>  nfs4.1/nfs4server.py             | 81 +++++++++++++++++---------------
>>  nfs4.1/nfs4state.py              | 46 +++++++++---------
>>  nfs4.1/sample_code/ds_exports.py |  2 +-
>>  nfs4.1/server_exports.py         | 12 ++---
>>  8 files changed, 129 insertions(+), 120 deletions(-)
>>
>> diff --git a/nfs4.1/config.py b/nfs4.1/config.py
>> index 3777e31..8691e1c 100644
>> --- a/nfs4.1/config.py
>> +++ b/nfs4.1/config.py
>> @@ -117,8 +117,7 @@ class MetaConfig(type):
>>              setattr(cls, attr.name, property(make_get(i), make_set(i),
>>                                               None, attr.comment))
>>
>> -class ServerConfig(object):
>> -    __metaclass__ =3D MetaConfig
>> +class ServerConfig(metaclass=3DMetaConfig):
>>      attrs =3D  [ConfigLine("allow_null_data", False,
>>                           "Server allows NULL calls to contain data"),
>>                ConfigLine("tag_info", True,
>> @@ -131,17 +130,16 @@ class ServerConfig(object):
>>
>>      def __init__(self):
>>          self.minor_id =3D os.getpid()
>> -        self.major_id =3D "PyNFSv4.1"
>> +        self.major_id =3D b"PyNFSv4.1"
>>          self._owner =3D server_owner4(self.minor_id, self.major_id)
>> -        self.scope =3D "Default_Scope"
>> -        self.impl_domain =3D "citi.umich.edu"
>> -        self.impl_name =3D "pynfs X.X"
>> +        self.scope =3D b"Default_Scope"
>> +        self.impl_domain =3D b"citi.umich.edu"
>> +        self.impl_name =3D b"pynfs X.X"
>>          self.impl_date =3D 1172852767 # int(time.time())
>>          self.impl_id =3D nfs_impl_id4(self.impl_domain, self.impl_name,
>>                                   nfs4lib.get_nfstime(self.impl_date))
>>
>> -class ServerPerClientConfig(object):
>> -    __metaclass__ =3D MetaConfig
>> +class ServerPerClientConfig(metaclass=3DMetaConfig):
>>      attrs =3D [ConfigLine("maxrequestsize", 16384,
>>                          "Maximum request size the server will accept"),
>>               ConfigLine("maxresponsesize", 16384,
>> @@ -175,15 +173,13 @@ _invalid_ops =3D [
>>      OP_RELEASE_LOCKOWNER, OP_ILLEGAL,
>>      ]
>>
>> -class OpsConfigServer(object):
>> -    __metaclass__ =3D MetaConfig
>> +class OpsConfigServer(metaclass=3DMetaConfig):
>>      value =3D ['ERROR', 0, 0] # Note must have value =3D=3D _opline(val=
ue)
>>      attrs =3D (lambda value=3Dvalue: [ConfigLine(name.lower()[3:], valu=
e, "Generic comment", _opline)
>>                                    for name in nfs_opnum4.values()])()
>>
>>
>> -class Actions(object):
>> -    __metaclass__ =3D MetaConfig
>> +class Actions(metaclass=3DMetaConfig):
>>      attrs =3D [ConfigLine("reboot", 0,
>>                          "Any write here will simulate a server reboot",
>>                          _action),
>> diff --git a/nfs4.1/dataserver.py b/nfs4.1/dataserver.py
>> index f76ca5a..4d3a305 100644
>> --- a/nfs4.1/dataserver.py
>> +++ b/nfs4.1/dataserver.py
>> @@ -59,27 +59,27 @@ class DataServer(object):
>>
>>      def get_netaddr4(self):
>>          # STUB server multipathing not supported yet
>> -        uaddr =3D '.'.join([self.server,
>> -                          str(self.port >> 8),
>> -                          str(self.port & 0xff)])
>> -        return type4.netaddr4(self.proto, uaddr)
>> +        uaddr =3D b'.'.join([self.server.encode("utf-8"),
>> +                          str(self.port >> 8).encode("utf-8"),
>> +                          str(self.port & 0xff).encode("utf-8")])
>> +        return type4.netaddr4(self.proto.encode("utf-8"), uaddr)
>>
>>      def get_multipath_netaddr4s(self):
>>          netaddr4s =3D []
>>          for addr in self.multipath_servers:
>>              server, port =3D addr
>> -            uaddr =3D '.'.join([server,
>> -                            str(port >> 8),
>> -                            str(port & 0xff)])
>> -            proto =3D "tcp"
>> +            uaddr =3D b'.'.join([server.encode("utf-8"),
>> +                            str(port >> 8).encode("utf-8"),
>> +                            str(port & 0xff).encode("utf-8")])
>> +            proto =3D b"tcp"
>>              if server.find(':') >=3D 0:
>> -                proto =3D "tcp6"
>> +                proto =3D b"tcp6"
>>
>>              netaddr4s.append(type4.netaddr4(proto, uaddr))
>>          return netaddr4s
>>
>>      def fh_to_name(self, mds_fh):
>> -        return hashlib.sha1("%r" % mds_fh).hexdigest()
>> +        return hashlib.sha1(mds_fh).hexdigest()
>>
>>      def connect(self):
>>          raise NotImplemented
>> @@ -111,7 +111,7 @@ class DataServer41(DataServer):
>>                  self.reset()
>>              else:
>>                  log.error("Unhandled status %s from DS %s" %
>> -                          (nfsstat4[res.status], self.server))
>> +                          (const4.nfsstat4[res.status], self.server))
>>                  raise Exception("Dataserver communication error")
>>
>>      def connect(self):
>> @@ -122,7 +122,7 @@ class DataServer41(DataServer):
>>                                          summary=3Dself.summary)
>>          self.c1.set_cred(self.cred1)
>>          self.c1.null()
>> -        c =3D self.c1.new_client("DS.init_%s" % self.server)
>> +        c =3D self.c1.new_client(b"DS.init_%s" % self.server.encode("ut=
f-8"))
>>          # This is a hack to ensure MDS/DS communication path is at leas=
t
>>          # as wide as the client/MDS channel (at least for linux client)
>>          fore_attrs =3D type4.channel_attrs4(0, 16384, 16384, 2868, 8, 8=
, [])
>> @@ -154,11 +154,11 @@ class DataServer41(DataServer):
>>          access =3D const4.OPEN4_SHARE_ACCESS_BOTH
>>          deny =3D const4.OPEN4_SHARE_DENY_NONE
>>          attrs =3D {const4.FATTR4_MODE: 0o777}
>> -        owner =3D "mds"
>> +        owner =3D b"mds"
>>          mode =3D const4.GUARDED4
>>          verifier =3D self.sess.c.verifier
>>          openflag =3D type4.openflag4(const4.OPEN4_CREATE, type4.createh=
ow4(mode, attrs, verifier))
>> -        name =3D self.fh_to_name(mds_fh)
>> +        name =3D self.fh_to_name(mds_fh).encode("utf-8")
>>          while True:
>>              if mds_fh in self.filehandles:
>>                  return
>> @@ -338,14 +338,14 @@ class DSDevice(object):
>>                  server_list =3D server_list[:-1]
>>                  try:
>>                      log.info("Adding dataserver ip:%s port:%s path:%s" =
%
>> -                             (server, port, '/'.join(path)))
>> +                             (server, port, b'/'.join(path)))
>>                      ds =3D DataServer41(server, port, path, mdsds=3Dsel=
f.mdsds,
>>                                      multipath_servers=3Dserver_list,
>>                                      summary=3Dserver_obj.summary)
>>                      self.list.append(ds)
>>                  except socket.error:
>>                      log.critical("cannot access %s:%i/%s" %
>> -                                 (server, port, '/'.join(path)))
>> +                                 (server, port, b'/'.join(path)))
>>                      sys.exit(1)
>>          self.active =3D 1
>>          self.address_body =3D self._get_address_body()
>> diff --git a/nfs4.1/fs.py b/nfs4.1/fs.py
>> index 7f690bb..31e7528 100644
>> --- a/nfs4.1/fs.py
>> +++ b/nfs4.1/fs.py
>> @@ -6,10 +6,7 @@ from nfs4lib import NFS4Error
>>  import struct
>>  import logging
>>  from locking import Lock, RWLock
>> -try:
>> -    import cStringIO.StringIO as StringIO
>> -except:
>> -    from io import StringIO
>> +from io import BytesIO
>>  import time
>>  from xdrdef.nfs4_pack import NFS4Packer
>>
>> @@ -17,6 +14,14 @@ log_o =3D logging.getLogger("fs.obj")
>>  log_fs =3D logging.getLogger("fs")
>>  logging.addLevelName(5, "FUNCT")
>>
>> +def _hasattr(obj, attr):
>> +    try:
>> +        getattr(obj, attr)
>> +        return True
>> +    except:
>> +        pass
>> +    return False
>> +
>>  class MetaData(object):
>>      """Contains everything that needs to be stored
>>
>> @@ -61,7 +66,7 @@ class FSObject(object):
>>      def _getsize_locked(self):
>>          # STUB
>>          if self.fattr4_type =3D=3D NF4REG:
>> -            if hasattr(self.file, "__len__"):
>> +            if _hasattr(self.file, "__len__"):
>>                  return len(self.file)
>>              else:
>>                  orig =3D self.file.tell()
>> @@ -182,13 +187,13 @@ class FSObject(object):
>>
>>      def init_file(self):
>>          """Hook for subclasses that want to use their own file class"""
>> -        return StringIO()
>> +        return BytesIO()
>>
>>      def _init_hook(self):
>>          pass
>>
>>      def __setattr__(self, name, value):
>> -        if name !=3D "meta" and hasattr(self.meta, name):
>> +        if name !=3D "meta" and _hasattr(self.meta, name):
>>              setattr(self.meta, name, value)
>>          else:
>>              object.__setattr__(self, name, value)
>> @@ -320,7 +325,8 @@ class FSObject(object):
>>                                      tag =3D "attr %i not writable" % at=
tr)
>>                  name =3D "fattr4_%s" % nfs4lib.attr_name(attr)
>>                  # Note all writable attrs are object attrs
>> -                if hasattr(self, name):
>> +
>> +                if _hasattr(self, name):
>>                      base =3D self
>>                  else:
>>                      base =3D self.meta
>> @@ -711,7 +717,7 @@ class ConfigObj(FSObject):
>>          self._reset()
>>
>>      def _reset(self):
>> -        self.file =3D StringIO()
>> +        self.file =3D BytesIO()
>>          self.file.write("# %s\n" % self.configline.comment)
>>          value =3D self.configline.value
>>          if type(value) is list:
>> @@ -931,7 +937,7 @@ import shutil
>>  import shelve
>>
>>  class StubFS_Disk(FileSystem):
>> -    _fs_data_name =3D "fs_info" # DB name where we store persistent dat=
a
>> +    _fs_data_name =3D b"fs_info" # DB name where we store persistent da=
ta
>>      def __init__(self, path, reset=3DFalse, fsid=3DNone):
>>          self._nextid =3D 0
>>          self.path =3D path
>> @@ -964,7 +970,7 @@ class StubFS_Disk(FileSystem):
>>          d["root"] =3D self.root.id
>>          d["fsid"] =3D self.fsid
>>          for attr in dir(self):
>> -            if attr.startswith("fattr4_") and not hasattr(self.__class_=
_, attr):
>> +            if attr.startswith("fattr4_") and not _hasattr(self.__class=
__, attr):
>>                  d[attr] =3D getattr(self, attr)
>>          d.sync()
>>
>> @@ -991,17 +997,17 @@ class StubFS_Disk(FileSystem):
>>          self.root =3D self.find(d["root"])
>>
>>      def find_on_disk(self, id):
>> -        fd =3D open(os.path.join(self.path, "m_%i" % id), "r")
>> +        fd =3D open(os.path.join(self.path, b"m_%i" % id), "rb")
>>          # BUG - need to trap for file not found error
>>          meta =3D pickle.load(fd)
>>          fd.close()
>>          obj =3D self.objclass(self, id, meta)
>>          if obj.type =3D=3D NF4REG:
>> -            fd =3D open(os.path.join(self.path, "d_%i" % id), "r")
>> -            obj.file =3D StringIO(fd.read())
>> +            fd =3D open(os.path.join(self.path, b"d_%i" % id), "rb")
>> +            obj.file =3D BytesIO(fd.read())
>>              fd.close()
>>          elif obj.type =3D=3D NF4DIR:
>> -            fd =3D open(os.path.join(self.path, "d_%i" % id), "r")
>> +            fd =3D open(os.path.join(self.path, b"d_%i" % id), "rb")
>>              obj.entries =3D pickle.load(fd)
>>              fd.close()
>>          return obj
>> @@ -1018,10 +1024,10 @@ class StubFS_Disk(FileSystem):
>>              self._fs_data["_nextid"] =3D id
>>              self._fs_data.sync()
>>              # Create meta-data file
>> -            fd =3D open(os.path.join(self.path, "m_%i" % id), "w")
>> +            fd =3D open(os.path.join(self.path, b"m_%i" % id), "wb")
>>              fd.close()
>>              # Create data file
>> -            # fd =3D open(os.path.join(self.path, "d_%i" % id), "w")
>> +            # fd =3D open(os.path.join(self.path, b"d_%i" % id), "wb")
>>              # fd.close()
>>          finally:
>>              self._disk_lock.release()
>> @@ -1032,11 +1038,11 @@ class StubFS_Disk(FileSystem):
>>          self._disk_lock.acquire()
>>          try:
>>              # Remove meta-data file
>> -            meta =3D os.path.join(self.path, "m_%i" % id)
>> +            meta =3D os.path.join(self.path, b"m_%i" % id)
>>              if os.path.isfile(meta):
>>                  os.remove(meta)
>>              # Remove data file
>> -            data =3D os.path.join(self.path, "d_%i" % id)
>> +            data =3D os.path.join(self.path, b"d_%i" % id)
>>              if os.path.isfile(data):
>>                  os.remove(data)
>>          finally:
>> @@ -1049,20 +1055,20 @@ class StubFS_Disk(FileSystem):
>>          try:
>>              # Create meta-data file
>>              log_fs.debug("writing metadata for id=3D%i" % id)
>> -            fd =3D open(os.path.join(self.path, "m_%i" % id), "w")
>> +            fd =3D open(os.path.join(self.path, b"m_%i" % id), "wb")
>>              log_fs.debug("%r" % obj.meta.__dict__)
>>              pickle.dump(obj.meta, fd)
>>              fd.close()
>>              if obj.type =3D=3D NF4REG:
>>                  # Create data file
>> -                fd =3D open(os.path.join(self.path, "d_%i" % id), "w")
>> +                fd =3D open(os.path.join(self.path, b"d_%i" % id), "wb"=
)
>>                  obj.file.seek(0)
>>                  fd.write(obj.file.read())
>>                  fd.close()
>>              elif obj.type =3D=3D NF4DIR:
>>                  # Create dir entries
>>                  log_fs.debug("writing dir %r" % obj.entries.keys())
>> -                fd =3D open(os.path.join(self.path, "d_%i" % id), "w")
>> +                fd =3D open(os.path.join(self.path, b"d_%i" % id), "wb"=
)
>>                  pickle.dump(obj.entries, fd)
>>                  fd.close()
>>          finally:
>> @@ -1408,7 +1414,7 @@ class FSLayoutFSObj(FSObject):
>>      def init_file(self):
>>          self.stripe_size =3D NFL4_UFLG_STRIPE_UNIT_SIZE_MASK & 0x4000
>>          if self.fs.dsdevice.mdsds:
>> -            return StringIO()
>> +            return BytesIO()
>>          else:
>>              return FileLayoutFile(self)
>>
>> diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
>> index 25d7fd1..cf844e1 100644
>> --- a/nfs4.1/nfs4client.py
>> +++ b/nfs4.1/nfs4client.py
>> @@ -183,7 +183,7 @@ class NFS4Client(rpc.Client, rpc.Server):
>>                  return env
>>          try:
>>              self.check_utf8str_cs(args.tag)
>> -        except NFS4Errror as e:
>> +        except NFS4Error as e:
>>              env.results.set_empty_return(e.status, "Invalid utf8 tag")
>>              return env
>>          # Handle the individual operations
>> @@ -211,7 +211,7 @@ class NFS4Client(rpc.Client, rpc.Server):
>>                  except NFS4Replay:
>>                      # Just pass this on up
>>                      raise
>> -                except Exception:
>> +                except StandardError:
>>                      # Uh-oh.  This is a server bug
>>                      traceback.print_exc()
>>                      result =3D encode_status_by_name(opname.lower()[3:]=
,
>> diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
>> index d51732b..16ef113 100755
>> --- a/nfs4.1/nfs4server.py
>> +++ b/nfs4.1/nfs4server.py
>> @@ -16,17 +16,25 @@ import random
>>  import struct
>>  import collections
>>  import logging
>> -from nfs4state import find_state
>> +from nfs4state import find_state, SHARE, BYTE
>>  from nfs4commoncode import CompoundState, encode_status, encode_status_=
by_name
>>  from fs import RootFS, ConfigFS
>>  from config import ServerConfig, ServerPerClientConfig, OpsConfigServer=
, Actions
>>
>> -logging.basicConfig(level=3Dlogging.WARN,
>> +logging.basicConfig(level=3Dlogging.DEBUG,
>>                      format=3D"%(levelname)-7s:%(name)s:%(message)s")
>>  log_41 =3D logging.getLogger("nfs.server")
>>
>>  log_cfg =3D logging.getLogger("nfs.server.opconfig")
>>
>> +def _hasattr(obj, attr):
>> +    try:
>> +        getattr(obj, attr)
>> +        return True
>> +    except:
>> +        pass
>> +    return False
>> +
>>  ##################################################
>>  # Set various global constants and magic numbers #
>>  ##################################################
>> @@ -365,7 +373,7 @@ class SessionRecord(object):
>>      """The server's representation of a session and its state"""
>>      def __init__(self, client, csa):
>>          self.client =3D client # reference back to client which created=
 this session
>> -        self.sessionid =3D "%08x%08x" % (client.clientid,
>> +        self.sessionid =3D b"%08x%08x" % (client.clientid,
>>                                      client.session_replay.seqid) # XXX =
does this work?
>>          self.channel_fore =3D Channel(csa.csa_fore_chan_attrs, client.c=
onfig) # Normal communication
>>          self.channel_back =3D Channel(csa.csa_back_chan_attrs, client.c=
onfig) # Callback communication
>> @@ -574,14 +582,14 @@ class NFS4Server(rpc.Server):
>>          self.config =3D ServerConfig()
>>          self.opsconfig =3D OpsConfigServer()
>>          self.actions =3D Actions()
>> -        self.mount(ConfigFS(self), path=3D"/config")
>> +        self.mount(ConfigFS(self), path=3Db"/config")
>>          self.verifier =3D struct.pack('>d', time.time())
>>          self.recording =3D Recording()
>>          self.devid_counter =3D Counter(name=3D"devid_counter")
>>          self.devids =3D {} # {devid: device}
>>          # default cred for the backchannel -- currently supports only A=
UTH_SYS
>>          rpcsec =3D rpc.security.instance(rpc.AUTH_SYS)
>> -        self.default_cred =3D rpcsec.init_cred(uid=3D4321,gid=3D42,name=
=3D"mystery")
>> +        self.default_cred =3D rpcsec.init_cred(uid=3D4321,gid=3D42,name=
=3Db"mystery")
>>          self.err_inc_dict =3D self.init_err_inc_dict()
>>
>>      def start(self):
>> @@ -796,7 +804,7 @@ class NFS4Server(rpc.Server):
>>          self.check_utf8str_cs(str)
>>          if not str:
>>              raise NFS4Error(NFS4ERR_INVAL, tag=3D"Empty component")
>> -        if '/' in str:
>> +        if b'/' in str:
>>              raise NFS4Error(NFS4ERR_BADCHAR)
>>
>>      def op_compound(self, args, cred):
>> @@ -808,7 +816,7 @@ class NFS4Server(rpc.Server):
>>              return env
>>          try:
>>              self.check_utf8str_cs(args.tag)
>> -        except NFS4Errror as e:
>> +        except NFS4Error as e:
>>              env.results.set_empty_return(e.status, "Invalid utf8 tag")
>>              return env
>>          # Handle the individual operations
>> @@ -834,10 +842,10 @@ class NFS4Server(rpc.Server):
>>                      # catch error themselves to encode properly.
>>                      result =3D encode_status_by_name(opname.lower()[3:]=
,
>>                                                     e.status, msg=3De.ta=
g)
>> -                except NFS4Replay:
>> +                except NFS4Replay as e:
>>                      # Just pass this on up
>>                      raise
>> -                except Exception:
>> +                except Exception as e:
>>                      # Uh-oh.  This is a server bug
>>                      traceback.print_exc()
>>                      result =3D encode_status_by_name(opname.lower()[3:]=
,
>> @@ -919,7 +927,7 @@ class NFS4Server(rpc.Server):
>>          check_session(env, unique=3DTrue)
>>          if arg.csa_flags & ~nfs4lib.create_session_mask:
>>              return encode_status(NFS4ERR_INVAL,
>> -                                 msg=3D"Unknown bits set in flag")
>> +                                 msg=3Db"Unknown bits set in flag")
>>          # Step 1: Client record lookup
>>          c =3D self.clients[arg.csa_clientid]
>>          if c is None: # STUB - or if c.frozen ???
>> @@ -982,13 +990,13 @@ class NFS4Server(rpc.Server):
>>          if protect.type !=3D SP4_SSV:
>>              # Per draft26 18.47.3
>>              return encode_status(NFS4ERR_INVAL,
>> -                                 msg=3D"Did not request SP4_SSV protect=
ion")
>> +                                 msg=3Db"Did not request SP4_SSV protec=
tion")
>>          # Do some argument checking
>>          size =3D protect.context.ssv_len
>>          if len(arg.ssa_ssv) !=3D size:
>> -            return encode_status(NFS4ERR_INVAL, msg=3D"SSV size !=3D %i=
" % size)
>> +            return encode_status(NFS4ERR_INVAL, msg=3Db"SSV size !=3D %=
i" % size)
>>          if arg.ssa_ssv =3D=3D "\0" * size:
>> -            return encode_status(NFS4ERR_INVAL, msg=3D"SSV=3D=3D0 not a=
llowed")
>> +            return encode_status(NFS4ERR_INVAL, msg=3Db"SSV=3D=3D0 not =
allowed")
>>          # Now we need to compute and check digest, using SEQUENCE args
>>          p =3D nfs4lib.FancyNFS4Packer()
>>          p.pack_SEQUENCE4args(env.argarray[0].opsequence)
>> @@ -1009,10 +1017,10 @@ class NFS4Server(rpc.Server):
>>          check_session(env, unique=3DTrue)
>>          # Check arguments for blatent errors
>>          if arg.eia_flags & ~nfs4lib.exchgid_mask:
>> -            return encode_status(NFS4ERR_INVAL, msg=3D"Unknown flag")
>> +            return encode_status(NFS4ERR_INVAL, msg=3Db"Unknown flag")
>>          if arg.eia_flags & EXCHGID4_FLAG_CONFIRMED_R:
>>              return encode_status(NFS4ERR_INVAL,
>> -                                 msg=3D"Client used server-only flag")
>> +                                 msg=3Db"Client used server-only flag")
>>          if arg.eia_client_impl_id:
>>              impl_id =3D arg.eia_client_impl_id[0]
>>              self.check_utf8str_cis(impl_id.nii_domain)
>> @@ -1034,7 +1042,7 @@ class NFS4Server(rpc.Server):
>>              if c is None:
>>                  if update:
>>                      # Case 7
>> -                    return encode_status(NFS4ERR_NOENT, msg=3D"No such =
client")
>> +                    return encode_status(NFS4ERR_NOENT, msg=3Db"No such=
 client")
>>                  else:
>>                      # The simple, common case 1: a new client
>>                      c =3D self.clients.add(arg, env.principal, self.sec=
_flavors)
>> @@ -1042,7 +1050,7 @@ class NFS4Server(rpc.Server):
>>                  if update:
>>                      # Case 7
>>                      return encode_status(NFS4ERR_NOENT,
>> -                                         msg=3D"Client not confirmed")
>> +                                         msg=3Db"Client not confirmed")
>>                  else:
>>                      # Case 4
>>                      self.clients.remove(c.clientid)
>> @@ -1057,11 +1065,11 @@ class NFS4Server(rpc.Server):
>>                      if c.verifier !=3D verf:
>>                          # Case 8
>>                          return encode_status(NFS4ERR_NOT_SAME,
>> -                                             msg=3D"Verifier mismatch")
>> +                                             msg=3Db"Verifier mismatch"=
)
>>                      elif c.principal !=3D env.principal:
>>                          # Case 9
>>                          return encode_status(NFS4ERR_PERM,
>> -                                             msg=3D"Principal mismatch"=
)
>> +                                             msg=3Db"Principal mismatch=
")
>>                      else:
>>                          # Case 6 - update
>>                          c.update(arg, env.principal)
>> @@ -1069,7 +1077,7 @@ class NFS4Server(rpc.Server):
>>                      # Case 3
>>                      # STUB - need to check state
>>                      return encode_status(NFS4ERR_CLID_INUSE,
>> -                                         msg=3D"Principal mismatch")
>> +                                         msg=3Db"Principal mismatch")
>>                  elif c.verifier !=3D verf:
>>                      # Case 5
>>                      # Confirmed client reboot: this is the hard case
>> @@ -1103,7 +1111,7 @@ class NFS4Server(rpc.Server):
>>                                  c.protection.rv(arg.eia_state_protect),
>>                                  self.config._owner, self.config.scope,
>>                                  [self.config.impl_id])
>> -        return encode_status(NFS4_OK, res, msg=3D"draft21")
>> +        return encode_status(NFS4_OK, res, msg=3Db"draft21")
>>
>>      def client_reboot(self, c):
>>          # STUB - locking?
>> @@ -1143,9 +1151,9 @@ class NFS4Server(rpc.Server):
>>              if arg.bctsa_digest:
>>                  # QUESTION _INVAL or _BAD_SESSION_DIGEST also possible
>>                  return encode_status(NFS4ERR_CONN_BINDING_NOT_ENFORCED,
>> -                                     msg=3D"Expected zero length digest=
")
>> +                                     msg=3Db"Expected zero length diges=
t")
>>              if arg.bctsa_step1 is False:
>> -                return encode_status(NFS4ERR_INVAL, msg=3D"Expected ste=
p1=3D=3DTrue")
>> +                return encode_status(NFS4ERR_INVAL, msg=3Db"Expected st=
ep1=3D=3DTrue")
>>              dir =3D bind_to_channels(arg.bctsa_dir)
>>              nonce =3D session.get_nonce(connection, [arg.bctsa_nonce])
>>              # STUB this should be a session method
>> @@ -1175,9 +1183,9 @@ class NFS4Server(rpc.Server):
>>                  old_s_nonce, old_c_nonce =3D session.nonce[connection]
>>              except KeyError:
>>                  return encode_status(NFS4ERR_INVAL,
>> -                                     msg=3D"server has no record of ste=
p1")
>> +                                     msg=3Db"server has no record of st=
ep1")
>>              if old_c_nonce =3D=3D arg.bctsa_nonce:
>> -                return encode_status(NFS4ERR_INVAL, msg=3D"Client reuse=
d nonce")
>> +                return encode_status(NFS4ERR_INVAL, msg=3Db"Client reus=
ed nonce")
>>              p =3D nfs4lib.FancyNFS4Packer()
>>              p.pack_bctsr_digest_input4(bctsr_digest_input4(arg.bctsa_se=
ssid,
>>                                                             arg.bctsa_no=
nce,
>> @@ -1208,8 +1216,7 @@ class NFS4Server(rpc.Server):
>>          check_session(env)
>>          # xxx add gss support
>>          secinfo4_list =3D [ secinfo4(rpc.AUTH_SYS) ]
>> -        res =3D SECINFO_NO_NAME4res(NFS4_OK, secinfo4_list)
>> -        return encode_status(NFS4_OK, res)
>> +        return encode_status(NFS4_OK, secinfo4_list)
>>
>>      # op_putpubfh SHOULD be the same as op_putrootfh
>>      # See draft23, section 18.20.3, line 25005
>> @@ -1356,14 +1363,14 @@ class NFS4Server(rpc.Server):
>>          claim_type =3D arg.claim.claim
>>          if claim_type !=3D CLAIM_NULL and arg.openhow.opentype =3D=3D O=
PEN4_CREATE:
>>              return encode_status(NFS4ERR_INVAL,
>> -                                 msg=3D"OPEN4_CREATE not compatible wit=
h %s" %
>> +                                 msg=3Db"OPEN4_CREATE not compatible wi=
th %s" %
>>                                   open_claim_type4[claim_type])
>>          # emulate switch(claim_type)
>>          try:
>>              func =3D getattr(self,
>>                             "open_%s" % open_claim_type4[claim_type].low=
er())
>>          except AttributeError:
>> -            return encode_status(NFS4ERR_NOTSUPP, msg=3D"Unsupported cl=
aim type")
>> +            return encode_status(NFS4ERR_NOTSUPP, msg=3Db"Unsupported c=
laim type")
>>          existing, cinfo, bitmask =3D func(arg, env)
>>          # existing now points to file we want to open
>>          if existing is None:
>> @@ -1462,7 +1469,7 @@ class NFS4Server(rpc.Server):
>>              ace =3D nfsace4(ACE4_ACCESS_DENIED_ACE_TYPE, 0,
>>                            ACE4_GENERIC_EXECUTE |
>>                            ACE4_GENERIC_WRITE | ACE4_GENERIC_READ,
>> -                          "EVERYONE@")
>> +                          b"EVERYONE@")
>>              deleg =3D open_read_delegation4(entry.get_id(), False, ace)
>>              return open_delegation4(entry.deleg_type, deleg)
>>
>> @@ -1511,7 +1518,7 @@ class NFS4Server(rpc.Server):
>>              else:
>>                  base =3D obj
>>              name =3D "fattr4_%s" % nfs4lib.attr_name(attr)
>> -            if hasattr(base, name) and (obj.fs.fattr4_supported_attrs &=
 1<<attr): # STUB we should be able to remove hasattr
>> +            if _hasattr(base, name) and (obj.fs.fattr4_supported_attrs =
& 1<<attr): # STUB we should be able to remove hasattr
>>                  ret_dict[attr] =3D getattr(base, name)
>>              else:
>>                  if ignore:
>> @@ -1557,7 +1564,7 @@ class NFS4Server(rpc.Server):
>>          check_cfh(env)
>>          env.cfh.check_dir()
>>          if arg.cookie in (1, 2) or \
>> -               (arg.cookie=3D=3D0 and arg.cookieverf !=3D "\0" * 8):
>> +               (arg.cookie=3D=3D0 and arg.cookieverf !=3D b"\0" * 8):
>>              return encode_status(NFS4ERR_BAD_COOKIE)
>>          objlist, verifier =3D env.cfh.readdir(arg.cookieverf, env.sessi=
on.client, env.principal) # (name, obj) pairs
>>          # STUB - think through rdattr_error handling
>> @@ -1690,7 +1697,7 @@ class NFS4Server(rpc.Server):
>>          check_session(env)
>>          check_cfh(env)
>>          if env.cfh.fattr4_type !=3D NF4LNK:
>> -            return encode_status(NFS4_INVAL, msg=3D"cfh type was %i" % =
i)
>> +            return encode_status(NFS4_INVAL, msg=3Db"cfh type was %i" %=
 i)
>>          res =3D READLINK4resok(env.cfh.linkdata)
>>          return encode_status(NFS4_OK, res)
>>
>> @@ -1734,7 +1741,7 @@ class NFS4Server(rpc.Server):
>>          self.check_component(arg.newname)
>>          if not nfs4lib.test_equal(env.sfh.fattr4_fsid, env.cfh.fattr4_f=
sid,
>>                                    kind=3D"fsid4"):
>> -            return encode_status(NFS4ERR_XDEV, msg=3D"%r !=3D %r" % (en=
v.sfh.fattr4_fsid, env.cfh.fattr4_fsid))
>> +            return encode_status(NFS4ERR_XDEV, msg=3Db"%r !=3D %r" % (e=
nv.sfh.fattr4_fsid, env.cfh.fattr4_fsid))
>>          order =3D sorted(set([env.cfh, env.sfh])) # Used to prevent loc=
king problems
>>          # BUG fs locking
>>          old_change_src =3D env.sfh.fattr4_change
>> @@ -1891,10 +1898,10 @@ class NFS4Server(rpc.Server):
>>              check_session(env)
>>              check_cfh(env)
>>              if arg.loga_length =3D=3D 0:
>> -                return encode_status(NFS4_INVAL, msg=3D"length =3D=3D 0=
")
>> +                return encode_status(NFS4_INVAL, msg=3Db"length =3D=3D =
0")
>>              if arg.loga_length !=3D 0xffffffffffffffff:
>>                  if arg.loga_length + arg.loga_offset > 0xffffffffffffff=
ff:
>> -                     return encode_status(NFS4_INVAL, msg=3D"offset+len=
gth too big")
>> +                     return encode_status(NFS4_INVAL, msg=3Db"offset+le=
ngth too big")
>>              if not env.session.has_backchannel:
>>                  raise NFS4Error(NFS4ERR_LAYOUTTRYLATER)
>>              # STUB do state locking and check on iomode,offset,length t=
riple
>> @@ -2047,7 +2054,7 @@ class NFS4Server(rpc.Server):
>>          # "The server MUST specify...an ONC RPC version number equal to=
 4",
>>          # Per the May 17, 2010 discussion on the ietf list, errataID 22=
91
>>          # indicates it should in fact be 1
>> -        return pipe.send_call(prog, 1, 0, "", credinfo)
>> +        return pipe.send_call(prog, 1, 0, b"", credinfo)
>>
>>      def cb_null(self, prog, pipe, credinfo=3DNone):
>>          """ Sends bc_null."""
>> diff --git a/nfs4.1/nfs4state.py b/nfs4.1/nfs4state.py
>> index e57b90a..3ff6cdf 100644
>> --- a/nfs4.1/nfs4state.py
>> +++ b/nfs4.1/nfs4state.py
>> @@ -21,7 +21,7 @@ POSIXLOCK =3D False
>>  SHARE, BYTE, DELEG, LAYOUT, ANON =3D range(5) # State types
>>  NORMAL, CB_INIT, CB_SENT, CB_RECEIVED, INVALID =3D range(5) # delegatio=
n/layout states
>>
>> -DS_MAGIC =3D "\xa5" # STUB part of HACK code to ignore DS stateid
>> +DS_MAGIC =3D b"\xa5" # STUB part of HACK code to ignore DS stateid
>>
>>  @contextmanager
>>  def find_state(env, stateid, allow_0=3DTrue, allow_bypass=3DFalse):
>> @@ -34,7 +34,7 @@ def find_state(env, stateid, allow_0=3DTrue, allow_byp=
ass=3DFalse):
>>          # Could meddle with state.other here if needed
>>          anon =3D True
>>      # First we convert special stateids, see draft22 8.2.3
>> -    if stateid.other =3D=3D "\0" * 12:
>> +    if stateid.other =3D=3D b"\0" * 12:
>>          if allow_0 and stateid.seqid =3D=3D 0:
>>              state =3D env.cfh.state.anon0
>>              anon =3D True
>> @@ -43,10 +43,10 @@ def find_state(env, stateid, allow_0=3DTrue, allow_b=
ypass=3DFalse):
>>              # Special stateids must be passed in explicitly
>>              if stateid in [None, nfs4lib.state00, nfs4lib.state11]:
>>                  raise NFS4Error(NFS4ERR_BAD_STATEID,
>> -                                tag=3D"Current stateid not useable")
>> +                                tag=3Db"Current stateid not useable")
>>          else:
>>              raise NFS4Error(NFS4ERR_BAD_STATEID)
>> -    elif stateid.other =3D=3D "\xff" * 12:
>> +    elif stateid.other =3D=3D b"\xff" * 12:
>>          if allow_0 and stateid.seqid =3D=3D 0xffffffff:
>>              stateid =3D nfs4lib.state00 # Needed to pass seqid checks b=
elow
>>              state =3D (env.cfh.state.anon1 if allow_bypass else env.cfh=
.state.anon0)
>> @@ -57,31 +57,31 @@ def find_state(env, stateid, allow_0=3DTrue, allow_b=
ypass=3DFalse):
>>          # Now map stateid to find state
>>          state =3D env.session.client.state.get(stateid.other, None)
>>          if state is None:
>> -            raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3D"stateid not kno=
wn")
>> +            raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3Db"stateid not kn=
own")
>>          if state.file !=3D env.cfh:
>>              raise NFS4Error(NFS4ERR_BAD_STATEID,
>> -                            tag=3D"cfh %r does not match stateid %r" %
>> +                            tag=3Db"cfh %r does not match stateid %r" %
>>                              (state.file.fh, env.cfh.fh))
>>      state.lock.acquire()
>>      # It is possible that while waiting to get the lock, the state has =
been
>>      # removed.  In that case, the removal sets the invalid flag.
>>      if state.invalid:
>>          state.release()
>> -        raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3D"stateid not known (=
race)")
>> +        raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3Db"stateid not known =
(race)")
>>      if state.type !=3D LAYOUT:
>>          # See draft22 8.2.2
>>          if stateid.seqid !=3D 0 and stateid.seqid !=3D state.seqid:
>>              old =3D (stateid.seqid < state.seqid)
>>              state.lock.release()
>>              if old:
>> -                raise NFS4Error(NFS4ERR_OLD_STATEID, tag=3D"bad stateid=
.seqid")
>> +                raise NFS4Error(NFS4ERR_OLD_STATEID, tag=3Db"bad statei=
d.seqid")
>>              else:
>> -                raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3D"bad stateid=
.seqid")
>> +                raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3Db"bad statei=
d.seqid")
>>      else:
>>          # See draft22 12.5.3
>>          if stateid.seqid =3D=3D 0:
>>              state.lock.release()
>> -            raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3D"layout stateid.=
seqid=3D=3D0")
>> +            raise NFS4Error(NFS4ERR_BAD_STATEID, tag=3Db"layout stateid=
.seqid=3D=3D0")
>>      try:
>>          yield state
>>      finally:
>> @@ -215,10 +215,10 @@ class DictTree(object):
>>      def itervalues(self):
>>          def myiter(d, depth):
>>              if depth =3D=3D 1:
>> -                for value in d.itervalues():
>> +                for value in d.values():
>>                      yield value
>>              else:
>> -                for sub_d in d.itervalues():
>> +                for sub_d in d.values():
>>                      for i in myiter(sub_d, depth - 1):
>>                          yield i
>>          for i in myiter(self._data, self._depth):
>> @@ -250,7 +250,7 @@ class FileStateTyped(object):
>>          # NOTE we are only using 9 bytes of 12
>>          # NOTE this needs to be client-wide, since keys of client.state=
[]
>>          # must be unique
>> -        return "%s%s" % (struct.pack("!xxxB", self.type),
>> +        return b"%s%s" % (struct.pack("!xxxB", self.type),
>>                           client.get_new_other())
>>
>>      def grab_entry(self, key, klass):
>> @@ -290,13 +290,13 @@ class DelegState(FileStateTyped):
>>              return True
>>          # Find any delegation - use fact that all are of same type
>>          for e in self._tree.itervalues():
>> +            # The only thing that doesn't conflict is access=3D=3DREAD =
with READ deleg
>> +            if e.deleg_type =3D=3D OPEN_DELEGATE_READ and \
>> +                    not (access & OPEN4_SHARE_ACCESS_WRITE):
>> +                return False
>> +            else:
>> +                return True
>>              break
>> -        # The only thing that doesn't conflict is access=3D=3DREAD with=
 READ deleg
>> -        if e.deleg_type =3D=3D OPEN_DELEGATE_READ and \
>> -                not (access & OPEN4_SHARE_ACCESS_WRITE):
>> -            return False
>> -        else:
>> -            return True
>>
>>      def recall_conflicting_delegations(self, dispatcher, client, access=
, deny):
>>          # NOTE OK to have extra access/deny flags
>> @@ -342,8 +342,8 @@ class AnonState(FileStateTyped):
>>      def __init__(self, *args, **kwargs):
>>          kwargs["depth"] =3D 1 # key =3D (int,)
>>          FileStateTyped.__init__(self, *args, **kwargs)
>> -        self._tree[(0 ,)] =3D AnonEntry("\x00" * 12, self, (0,))
>> -        self._tree[(1 ,)] =3D AnonEntry("\xff" * 12, self, (1,))
>> +        self._tree[(0 ,)] =3D AnonEntry(b"\x00" * 12, self, (0,))
>> +        self._tree[(1 ,)] =3D AnonEntry(b"\xff" * 12, self, (1,))
>>          self._tree[(DS_MAGIC, )] =3D DSEntry(DS_MAGIC * 12, self, (DS_M=
AGIC, ))
>>
>>  class ShareState(FileStateTyped):
>> @@ -686,9 +686,9 @@ class ShareEntry(StateTableEntry):
>>  #             # This test is the whole reason for the silly 3-bit
>>  #             # representation.  It basically prevents the seqence
>>  #             # OPEN(share=3DBOTH), OPENDOWNGRADE(share=3DSINGLE).
>> -#             raise NFS4Error(NFS4ERR_INVAL, tag=3D"Failed history test=
")
>> +#             raise NFS4Error(NFS4ERR_INVAL, tag=3Db"Failed history tes=
t")
>>  #         if access =3D=3D 0 and deny !=3D 0:
>> -#             raise NFS4Error(NFS4ERR_INVAL, tag=3D"access=3D=3D0")
>> +#             raise NFS4Error(NFS4ERR_INVAL, tag=3Db"access=3D=3D0")
>>  #         self.access_hist, self.deny_hist =3D new_access, new_deny
>>  #         self.share_access, self.share_deny =3D access, deny
>>
>> diff --git a/nfs4.1/sample_code/ds_exports.py b/nfs4.1/sample_code/ds_ex=
ports.py
>> index 5d31148..1975e16 100644
>> --- a/nfs4.1/sample_code/ds_exports.py
>> +++ b/nfs4.1/sample_code/ds_exports.py
>> @@ -6,4 +6,4 @@ from fs import StubFS_Mem
>>
>>  def mount_stuff(server, opts):
>>      B =3D StubFS_Mem(2)
>> -    server.mount(B, path=3D"/pynfs_mds")
>> +    server.mount(B, path=3Db"/pynfs_mds")
>> diff --git a/nfs4.1/server_exports.py b/nfs4.1/server_exports.py
>> index ef857ee..1271c4a 100644
>> --- a/nfs4.1/server_exports.py
>> +++ b/nfs4.1/server_exports.py
>> @@ -4,22 +4,22 @@ from dataserver import DSDevice
>>  def mount_stuff(server, opts):
>>      """Mount some filesystems to the server"""
>>      # STUB - just testing stuff out
>> -    A =3D StubFS_Disk("/tmp/py41/fs1", opts.reset, 1)
>> +    A =3D StubFS_Disk(b"/tmp/py41/fs1", opts.reset, 1)
>>      B =3D StubFS_Mem(2)
>>      C =3D StubFS_Mem(3)
>> -    server.mount(A, path=3D"/a")
>> -    server.mount(B, path=3D"/b")
>> -    server.mount(C, path=3D"/foo/bar/c")
>> +    server.mount(A, path=3Db"/a")
>> +    server.mount(B, path=3Db"/b")
>> +    server.mount(C, path=3Db"/foo/bar/c")
>>      if opts.use_block:
>>          dev =3D _create_simple_block_dev()
>>          E =3D BlockLayoutFS(5, backing_device=3Ddev)
>> -        server.mount(E, path=3D"/block")
>> +        server.mount(E, path=3Db"/block")
>>      if opts.use_files:
>>          dservers =3D _load_dataservers(opts.dataservers, server)
>>          if dservers is None:
>>              return
>>          F =3D FileLayoutFS(6, dservers)
>> -        server.mount(F, path=3D"/files")
>> +        server.mount(F, path=3Db"/files")
>>
>>  def _create_simple_block_dev():
>>      from block import Simple, Slice, Concat, Stripe, BlockVolume
>> --
>> 2.53.0
>>


