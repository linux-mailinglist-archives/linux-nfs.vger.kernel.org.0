Return-Path: <linux-nfs+bounces-5187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA39400AB
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39513283E3A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BD78C98;
	Mon, 29 Jul 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhGxo0Ys"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AD18C35F
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290189; cv=none; b=D9hr93w+z5Uw2UsSCgwL1RiJ8gbVhwNE0gOsDdf0jKKBedF+JEHybgFsB8CCLAVA5sGAkJaZCixfq7rbVfW/PZuC+1uR0XFi+JKl3aJ/CygKajlCFRHeDinqdfwXQCeJmOXojTHOKxT+llYJrhxRblCS0/PHUd/m+zuTw8CVwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290189; c=relaxed/simple;
	bh=bFXBKMg/KySruoi6qX1n1wqepACFmfdRqeU/7cQF0sg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PMcalbUiwjaDhA5bMNUMT8NormPHZafnak/k2Ff1CjJNfJVRfrZERC1N24olw8PySPMyQt/lXV673mU9jTUZcl8DMNEfOeh/XnDhWOjei3mTGLStb2SPryMXc7pRzy3vkjFznmSefMKyahB6r/NOPduH8H7TZX6ZZ7RnZRRmHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhGxo0Ys; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd69e44596so24070155ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722290187; x=1722894987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slLA7DfyX/XjuBTiTlMWQWfiF3WJWi3pcs/EKCtTH3o=;
        b=QhGxo0Ys9Od0vl/XEmrtxZgU29q55M6UTDjW+uHPPaF/YEpps4SfRRL1sXBFOnR5oP
         9yQiVpDSdLrbFKCnNiGUuzmsrrucaOQ8aRDoEBQ9srVX5hU2MWqv7tuSrGDH5TjLTk5K
         6AkyH6oBw/rhSRZjMONR+w9X31PecMHLFNTF9pJCVqHgZEembjWYlxXJWmlWGDE6xdf2
         QGnjpTYYZ+aCW7iTE5mTJ0FHzvFSSwpXog6pCel+Q59BzPdPFztAK92vqadTfHAR/PiT
         p/pL3KpBO84FmKB7t5P/CJCeiYEKB66GShz5BzTOQn6UbwcrbBOQVAi0JEqu+YzyQ2jZ
         HJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290187; x=1722894987;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slLA7DfyX/XjuBTiTlMWQWfiF3WJWi3pcs/EKCtTH3o=;
        b=RFPsNO/bkdeWYPoKVVQFZKbISUU3UaavHXwEQwmHTx8depHqwC4Ayox4K9eDDGXnMg
         2qBEOHr4k2fLMXd0u1ooSUUzpUKBNOC4WIM7snjcyuKiN+G2uwKUbP2wo6uM4Pn2o1GY
         7YVcSqQRBSoHWHollFFGY8cikbKAVZtyTV6uZ72JxbOpPWWjU04dGFnjPM69xa/i89FQ
         WwN1cFqKOWNa2+FfTNCVD1z9mspqhQdvqdrqwT1v03HeiqqaNfucv2dix0FJw3pSWdEf
         LAY6VrHZxMXE5zkaVsVomqd0dBOGaV+dgpXTBfeDUC4SUH3OZRaGVnk+luH/GAt7ndzo
         mW9Q==
X-Gm-Message-State: AOJu0YyZvL81ksXjrQ1tCEkK5IOcSKs704FUJDBCv/vVcoqHKHVjAne0
	9ubyQHLRTwOjylvvDg3q7vR2+KxPWdEAX1Sv8mE0Oo/sX3I56/XG0gnUSw==
X-Google-Smtp-Source: AGHT+IGhiZbx9SOPDYxc5tzvf8GZ7GYNTq1YBThyUPqaho6orhm3h0LnQKm2ebZj3e0ctJcZGCIcPQ==
X-Received: by 2002:a17:902:e811:b0:1fd:8dfd:3553 with SMTP id d9443c01a7336-1ff37bec1cemr1384765ad.18.1722290185826;
        Mon, 29 Jul 2024 14:56:25 -0700 (PDT)
Received: from [192.168.86.113] (syn-076-091-193-045.res.spectrum.com. [76.91.193.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fdafsm88050565ad.52.2024.07.29.14.56.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 14:56:25 -0700 (PDT)
Message-ID: <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com>
Date: Mon, 29 Jul 2024 14:56:24 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: NFS client failure
Content-Language: en-US
From: marc eshel <eshel.marc@gmail.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
In-Reply-To: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/29/24 2:50 PM, marc eshel wrote:
>
> Using NFS client to connect (before a read) from the pNFS DS I see the 
> following on the NFS client side and the Ganesha Server side (The DS) 
>  any ideas what the client did not like.
>
> Thanks, Marc.
>
> Jul 28 10:26:04 svl-marcrh-node-1 kernel: NFS: permission(0:51/7169), 
> mask=0x81, res=0
>
> Jul 28 10:26:04 svl-marcrh-node-1 kernel: --> nfs41_call_sync_prepare 
> data->seq_server 00000000ff0f7422
>
> Jul 28 10:26:04 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:04 svl-marcrh-node-1 kernel: NFS: 
> nfs_update_inode(0:51/245760 fh_crc=0x11f91d95 ct=1 info=0x427e7f)
>
> Jul 28 10:26:04 svl-marcrh-node-1 kernel: NFS: dentry_delete(/file8m, 
> 48084c)
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: NFS: permission(0:51/7169), 
> mask=0x81, res=0
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: NFS: 
> nfs_update_inode(0:51/245760 fh_crc=0x11f91d95 ct=3 info=0x427e7f)
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: --> nfs41_call_sync_prepare 
> data->seq_server 00000000ff0f7422
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: <-- _nfs4_proc_getdeviceinfo 
> status=0
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node 
> stripe count  1
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node 
> ds_num 1
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: RPC:       Couldn't create 
> auth handle (flavor 390004)
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: --> nfs4_proc_create_session 
> clp=00000000bf42bf91 session=000000004af72bf8
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs4_init_channel_attrs: 
> Fore Channel : max_rqst_sz=1049620 max_resp_sz=1049480 max_ops=8 
> max_reqs=64
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs4_init_channel_attrs: 
> Back Channel : max_rqst_sz=4096 max_resp_sz=4096 max_resp_sz_cached=0 
> max_ops=2 max_reqs=16
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs4_proc_create_session 
> client>seqid 2 sessionid 4:1722187461:2:0
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: <-- 
> nfs41_proc_reclaim_complete status=0
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: --> nfs4_read_done
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: --> nfs4_read_done
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: --> nfs4_read_done
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: --> nfs4_read_done
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> ….
>
> Jul 28 10:26:05 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:06 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:06 svl-marcrh-node-1 kernel: NFS: 
> nfs_update_inode(0:51/245760 fh_crc=0x11f91d95 ct=2 info=0x27040)
>
> Jul 28 10:26:06 svl-marcrh-node-1 kernel: nfs4_close_done: ret = 0
>
> Jul 28 10:26:06 svl-marcrh-node-1 kernel: NFS: dentry_delete(/file8m, 
> 48084c)
>
> Jul 28 10:26:46 svl-marcrh-node-1 kernel: <-- 
> nfs41_proc_async_sequence status=0
>
> Jul 28 10:26:46 svl-marcrh-node-1 kernel: nfs41_sequence_process: 
> Error 0 free the slot
>
> Jul 28 10:26:46 svl-marcrh-node-1 kernel: nfs41_sequence_call_done 
> rpc_cred 000000008d476879
>
>      5.784003013 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    
> -2, anon_gid=    -2, , sys)
>
>      5.784031320 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :default options (options=03303002/ffffffff 
> root_squash   , ----, 34-, UDP, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, anon_gid=    -2, expire=      60, none, sys)
>
>      5.784048104 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :Final options   (options=023021e0/ffffffff 
> no_root_squash, RWrw, 34-, ---, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, anon_gid=    -2, expire=      60, sys)
>
>      5.784183909 395973 TRACE_GANESHA: [svc_15] nfs_null :NFS3 :DEBUG 
> :REQUEST PROCESSING: Calling NFS_NULL
>
>      5.784958341 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    
> -2, anon_gid=    -2, , sys)
>
>      5.784981736 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :default options (options=03303002/ffffffff 
> root_squash   , ----, 34-, UDP, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, anon_gid=    -2, expire=      60, none, sys)
>
>      5.785016198 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :Final options   (options=023021e0/ffffffff 
> no_root_squash, RWrw, 34-, ---, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, anon_gid=    -2, expire=      60, sys)
>
>      5.785062392 389339 TRACE_GANESHA: [svc_11] nfs4_Compound :NFS4 
> :DEBUG :COMPOUND: There are 1 operations, res = 0x7f2a20001be0, tag = 
> NO TAG
>
>      5.785114712 389339 TRACE_GANESHA: [svc_11] nfs4_Compound :NFS4 
> :F_DBG :COMPOUND: There are 1 operations nfs4 operations {EXCHANGE_ID}
>
>      5.785151123 389339 TRACE_GANESHA: [svc_11] process_one_op :NFS4 
> :DEBUG :Request 0: opcode 42 is OP_EXCHANGE_ID
>
>      5.785183182 389339 TRACE_GANESHA: [svc_11] nfs4_op_exchange_id 
> :CLIENT ID :DEBUG :EXCHANGE_ID pnfs_flags 0x00010000 eia_flags 0x00040101
>
>      5.785309869 389339 TRACE_GANESHA: [svc_11] inc_client_record_ref 
> :CLIENT ID :F_DBG :Increment refcount {0x7f2a200020a0 name=(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.785345676 389339 TRACE_GANESHA: [svc_11] inc_client_id_ref 
> :CLIENT ID :F_DBG :Increment refcount Clientid {0x7f2a200021a0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000001} UNCONFIRMED 
> Client={0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 reservations=0 
> refcount=1} to 1
>
>      5.785368820 389339 TRACE_GANESHA: [svc_11] dec_client_record_ref 
> :CLIENT ID :F_DBG :Decrement refcount now=1 {0x7f2a200020a0 
> name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.785382625 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.785395515 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.785416713 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :DEBUG :Status of OP_EXCHANGE_ID in position 0 = NFS4_OK, op response 
> size is 0 total response size is 36
>
>      5.785546764 389339 TRACE_GANESHA: [svc_11] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f2a20001e30 
> (resarraylen=1)
>
>      5.786242209 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    
> -2, anon_gid=    -2, , sys)
>
>      5.786274623 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :default options (options=03303002/ffffffff 
> root_squash   , ----, 34-, UDP, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, anon_gid=    -2, expire=      60, none, sys)
>
>      5.786292745 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :Final options   (options=023021e0/ffffffff 
> no_root_squash, RWrw, 34-, ---, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, anon_gid=    -2, expire=      60, sys)
>
>      5.786313843 395973 TRACE_GANESHA: [svc_15] nfs4_Compound :NFS4 
> :DEBUG :COMPOUND: There are 1 operations, res = 0x7f29fc001310, tag = 
> NO TAG
>
>      5.786329329 395973 TRACE_GANESHA: [svc_15] nfs4_Compound :NFS4 
> :F_DBG :COMPOUND: There are 1 operations nfs4 operations {EXCHANGE_ID}
>
>      5.786343154 395973 TRACE_GANESHA: [svc_15] process_one_op :NFS4 
> :DEBUG :Request 0: opcode 42 is OP_EXCHANGE_ID
>
>      5.786377249 395973 TRACE_GANESHA: [svc_15] nfs4_op_exchange_id 
> :CLIENT ID :DEBUG :EXCHANGE_ID pnfs_flags 0x00010000 eia_flags 0x00040101
>
>      5.786413732 395973 TRACE_GANESHA: [svc_15] dec_client_id_ref 
> :CLIENT ID :F_DBG :Decrement refcount Clientid {0x7f2a200021a0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000001} EXPIRED 
> Client={0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 reservations=0 
> refcount=1} refcount to 0
>
>      5.786426971 395973 TRACE_GANESHA: [svc_15] dec_client_id_ref 
> :CLIENT ID :F_DBG :Free Clientid refcount now=0 {0x7f2a200021a0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000001} EXPIRED 
> Client={0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 reservations=0 
> refcount=1}
>
>      5.786455632 395973 TRACE_GANESHA: [svc_15] dec_client_record_ref 
> :CLIENT ID :F_DBG :Decrement refcount now=1 {0x7f2a200020a0 
> name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.786478133 395973 TRACE_GANESHA: [svc_15] inc_client_record_ref 
> :CLIENT ID :F_DBG :Increment refcount {0x7f2a200020a0 name=(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.786496149 395973 TRACE_GANESHA: [svc_15] inc_client_id_ref 
> :CLIENT ID :F_DBG :Increment refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} UNCONFIRMED 
> Client={0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 reservations=0 
> refcount=1} to 1
>
>      5.786510720 395973 TRACE_GANESHA: [svc_15] dec_client_record_ref 
> :CLIENT ID :F_DBG :Decrement refcount now=1 {0x7f2a200020a0 
> name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.786524531 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.786537391 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.786551547 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :DEBUG :Status of OP_EXCHANGE_ID in position 0 = NFS4_OK, op response 
> size is 0 total response size is 36
>
>      5.786678902 395973 TRACE_GANESHA: [svc_15] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f29fc001560 
> (resarraylen=1)
>
>      5.786833586 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    
> -2, anon_gid=    -2, , sys)
>
>      5.786891569 389339 TRACE_GANESHA: [svc_11] nfs4_Compound :NFS4 
> :DEBUG :COMPOUND: There are 1 operations, res = 0x7f2a20002ae0, tag = 
> NO TAG
>
>      5.786907017 389339 TRACE_GANESHA: [svc_11] nfs4_Compound :NFS4 
> :F_DBG :COMPOUND: There are 1 operations nfs4 operations {CREATE_SESSION}
>
>      5.786938593 389339 TRACE_GANESHA: [svc_11] process_one_op :NFS4 
> :DEBUG :Request 0: opcode 43 is OP_CREATE_SESSION
>
>      5.786996781 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :DEBUG :CREATE_SESSION client addr=::ffff:10.11.56.193 
> clientid=Epoch=0x66a7e0c6 Counter=0x00000002 -------------------
>
>      5.787030153 389339 TRACE_GANESHA: [svc_11] inc_client_id_ref 
> :CLIENT ID :F_DBG :Increment refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} UNCONFIRMED 
> Client={0x7f2a200020a0 nam
>
> e=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1} 
> t_delta=0 reservations=0 refcount=2} to 2
>
>      5.787046306 389339 TRACE_GANESHA: [svc_11] inc_client_record_ref 
> :CLIENT ID :F_DBG :Increment refcount {0x7f2a200020a0 name=(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.787061232 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :F_DBG :Client Record 0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=2 cr_confirmed_rec=(nil) cr_unco
>
> nfirmed_rec=0x7f29fc0026d0
>
>      5.787074437 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :DEBUG :CREATE_SESSION clientid=Epoch=0x66a7e0c6 
> Counter=0x00000002 csa_sequence=1 clientid_cs_seq=1 data_oppos=0
>
>      5.787091144 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :F_DBG :Found 0x7f29fc0026d0 ClientID={Epoch=0x66a7e0c6 
> Counter=0x00000002} UNCONFIRMED Client={0x7f2a200020a0 name=(44:Linux 
> NFSv4.1
>
> svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 reservations=0 
> refcount=2
>
>      5.787115990 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :F_DBG :Fore Channel attributes ca_headerpadsize 0 
> ca_maxrequestsize 1049620 ca_maxresponsesize 1049480 
> ca_maxresponsesize_cached 758
>
> 4 ca_maxoperations 8 ca_maxrequests 64
>
>      5.787129437 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :F_DBG :Back Channel attributes ca_headerpadsize 0 
> ca_maxrequestsize 4096 ca_maxresponsesize 4096 
> ca_maxresponsesize_cached 0 ca_maxo
>
> perations 2 ca_maxrequests 16
>
>      5.787211408 389339 TRACE_GANESHA: [svc_11] inc_client_id_ref 
> :CLIENT ID :F_DBG :Increment refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} UNCONFIRMED 
> Client={0x7f2a200020a0 nam
>
> e=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2} 
> t_delta=0 reservations=0 refcount=3} to 3
>
>      5.787250959 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :F_DBG :Confirming new 0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} UNCONFIRMED 
> Client={0x7f2a200020a0 name=(44:Linu
>
> x NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 
> reservations=0 refcount=3
>
>      5.787313756 389339 TRACE_GANESHA: [svc_11] fs_create_clid_name 
> :CLIENT ID :DEBUG :Created client name [::ffff:10.11.56.193-(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com)]
>
>      5.787386559 389339 TRACE_GANESHA: [svc_11] fs_add_clid :CLIENT ID 
> :DEBUG :Created client dir 
> [/var/lib/nfs/ganesha/v4recov/node0/::ffff:10.11.56.193-(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com)]
>
>      5.787413463 389339 TRACE_GANESHA: [svc_11] nfs4_chk_clid_impl 
> :CLIENT ID :DEBUG :chk for 7397128053987475458
>
>      5.787441005 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :DEBUG :Confirmed 0x7f29fc0026d0 ClientID={Epoch=0x66a7e0c6 
> Counter=0x00000002} CONFIRMED Client={0x7f2a200020a0 name=(44:Linux NFSv4
>
> .1 svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 
> reservations=0 refcount=3
>
>      5.787457512 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :F_DBG :Client Record 0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=2 cr_confirmed_rec=0x7f29fc0026d
>
> 0 cr_unconfirmed_rec=(nil)
>
>      5.787526325 389339 TRACE_GANESHA: [svc_11] nfs4_op_create_session 
> :SESSIONS :DEBUG :success session 0x7f2a20002f40 
> {sessionid=(16:0x02000000c6e0a7660100000000000000)} csa_flags 0x3 
> csr_flags 0x2
>
>      5.787554916 389339 TRACE_GANESHA: [svc_11] dec_client_id_ref 
> :CLIENT ID :F_DBG :Decrement refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} CONFIRMED 
> Client={0x7f2a200020a0 name=
>
> (44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2} 
> t_delta=0 reservations=0 refcount=3} refcount to 2
>
>      5.787571861 389339 TRACE_GANESHA: [svc_11] dec_client_record_ref 
> :CLIENT ID :F_DBG :Decrement refcount now=1 {0x7f2a200020a0 
> name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.787585600 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.787598472 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.787612249 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :DEBUG :Status of OP_CREATE_SESSION in position 0 = NFS4_OK, op 
> response size is 112 total response size is 148
>
>      5.787721136 389339 TRACE_GANESHA: [svc_11] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f2a20002590 
> (resarraylen=1)
>
>      5.787906140 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    -2, a
>
> non_gid= -2,                , sys)
>
>      5.787946036 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :default options (options=03303002/ffffffff 
> root_squash   , ----, 34-, UDP, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, a
>
> non_gid=    -2, expire=      60, none, sys)
>
>      5.787975742 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :Final options   (options=023021e0/ffffffff 
> no_root_squash, RWrw, 34-, ---, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, a
>
> non_gid=    -2, expire=      60, sys)
>
>      5.788052517 395973 TRACE_GANESHA: [svc_15] nfs4_Compound :NFS4 
> :DEBUG :COMPOUND: There are 2 operations, res = 0x7f29fc002070, tag = 
> NO TAG
>
>      5.788087408 395973 TRACE_GANESHA: [svc_15] nfs4_Compound :NFS4 
> :F_DBG :COMPOUND: There are 2 operations nfs4 operations {SEQUENCE, 
> RECLAIM_COMPLETE}
>
>      5.788117846 395973 TRACE_GANESHA: [svc_15] process_one_op :NFS4 
> :DEBUG :Request 0: opcode 53 is OP_SEQUENCE
>
>      5.788165215 395973 TRACE_GANESHA: [svc_15] 
> nfs41_Session_Get_Pointer :SESSIONS :F_DBG :Get Session 
> sessionid=(16:0x02000000c6e0a7660100000000000000)
>
>      5.788187319 395973 TRACE_GANESHA: [svc_15] 
> nfs41_Session_Get_Pointer :SESSIONS :F_DBG :Session 
> sessionid=(16:0x02000000c6e0a7660100000000000000) Found
>
>      5.788242777 395973 TRACE_GANESHA: [svc_15] nfs4_op_sequence 
> :SESSIONS :DEBUG :SEQUENCE session=0x7f2a20002f40
>
>      5.788283602 395973 TRACE_GANESHA: [svc_15] 
> reserve_lease_or_expire :CLIENT ID :F_DBG :Reserve Lease 
> 0x7f29fc0026d0 ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} 
> CONFIRMED Client={0x7f2a200020a0 name=(44:Linux
>
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1} t_delta=0 
> reservations=1 refcount=2 (Valid=YES 60 seconds left
>
>      5.788305835 395973 TRACE_GANESHA: [svc_15] nfs4_op_sequence 
> :SESSIONS :F_DBG :Don't use session slot 0=0x7f2a20003900 for DRC
>
>      5.788320442 395973 TRACE_GANESHA: [svc_15] check_resp_room :NFS4 
> :F_DBG :Status of OP_SEQUENCE in position 0 is ok so far, op response 
> size = 40 total response size would be = 84 out of max 1049480/7584
>
>      5.788352724 395973 TRACE_GANESHA: [svc_15] check_session_conn 
> :SESSIONS :F_DBG :Comparing addr ::ffff:10.11.56.193:996 for 
> OP_SEQUENCE to Session bound addr ::ffff:10.11.56.193:996
>
>      5.788372492 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.788386706 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.788400303 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :DEBUG :Status of OP_SEQUENCE in position 0 = NFS4_OK, op response 
> size is 40 total response size is 76
>
>      5.788415252 395973 TRACE_GANESHA: [svc_15] process_one_op :NFS4 
> :DEBUG :Request 1: opcode 58 is OP_RECLAIM_COMPLETE
>
>      5.788429355 395973 TRACE_GANESHA: [svc_15] check_resp_room :NFS4 
> :F_DBG :Status of OP_RECLAIM_COMPLETE in position 1 is ok so far, op 
> response size = 4 total response size would be = 92 out of max 
> 1049480/7584
>
>      5.788465437 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.788479686 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.788492986 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :DEBUG :Status of OP_RECLAIM_COMPLETE in position 1 = NFS4_OK, op 
> response size is 4 total response size is 84
>
>      5.788512857 395973 TRACE_GANESHA: [svc_15] update_lease :CLIENT 
> ID :F_DBG :Update Lease 0x7f29fc0026d0 ClientID={Epoch=0x66a7e0c6 
> Counter=0x00000002} CONFIRMED Client={0x7f2a200020a0 name=(44:Linux 
> NFSv4.1 svl
>
> -marcrh-node-1.fyre.ibm.com) refcount=1} t_delta=0 reservations=0 
> refcount=2
>
>      5.788610239 395973 TRACE_GANESHA: [svc_15] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f29fc0022c0 
> (resarraylen=2)
>
>      5.789131433 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    -2, a
>
> non_gid= -2,                , sys)
>
>      5.789151102 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :default options (options=03303002/ffffffff 
> root_squash   , ----, 34-, UDP, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, a
>
> non_gid=    -2, expire=      60, none, sys)
>
>      5.789179306 389339 TRACE_GANESHA: [svc_11] export_check_access 
> :EXPORT :M_DBG :Final options   (options=023021e0/ffffffff 
> no_root_squash, RWrw, 34-, ---, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, a
>
> non_gid=    -2, expire=      60, sys)
>
>      5.789243406 389339 TRACE_GANESHA: [svc_11] nfs4_Compound :NFS4 
> :DEBUG :COMPOUND: There are 1 operations, res = 0x7f2a20001440, tag = 
> NO TAG
>
>      5.789270968 389339 TRACE_GANESHA: [svc_11] nfs4_Compound :NFS4 
> :F_DBG :COMPOUND: There are 1 operations nfs4 operations {DESTROY_SESSION}
>
>      5.789292769 389339 TRACE_GANESHA: [svc_11] process_one_op :NFS4 
> :DEBUG :Request 0: opcode 44 is OP_DESTROY_SESSION
>
>      5.789324008 389339 TRACE_GANESHA: [svc_11] 
> nfs41_Session_Get_Pointer :SESSIONS :F_DBG :Get Session 
> sessionid=(16:0x02000000c6e0a7660100000000000000)
>
>      5.789347635 389339 TRACE_GANESHA: [svc_11] 
> nfs41_Session_Get_Pointer :SESSIONS :F_DBG :Session 
> sessionid=(16:0x02000000c6e0a7660100000000000000) Found
>
>      5.789374279 389339 TRACE_GANESHA: [svc_11] check_session_conn 
> :SESSIONS :F_DBG :Comparing addr ::ffff:10.11.56.193:996 for 
> OP_DESTROY_SESSION to Session bound addr ::ffff:10.11.56.193:996
>
>      5.789396299 389339 TRACE_GANESHA: [svc_11] dec_client_id_ref 
> :CLIENT ID :F_DBG :Decrement refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} CONFIRMED 
> Client={0x7f2a200020a0 name=
>
> (44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1} 
> t_delta=0 reservations=0 refcount=2} refcount to 1
>
>      5.789410060 389339 TRACE_GANESHA: [svc_11] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f29fc0025b0 
> (resarraylen=2)
>
>      5.789450150 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.789463993 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.789463993 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.789477602 389339 TRACE_GANESHA: [svc_11] complete_op :NFS4 
> :DEBUG :Status of OP_DESTROY_SESSION in position 0 = NFS4_OK, op 
> response size is 4 total response size is 40
>
>      5.789564757 389339 TRACE_GANESHA: [svc_11] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f2a20001690 
> (resarraylen=1)
>
>      5.789753915 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :EXPORT_DEFAULTS (options=020021e0/0701f1ff 
> no_root_squash, RWrw,    , ---, TCP, ----, ,         , anon_uid=    -2, a
>
> non_gid= -2,                , sys)
>
>      5.789787721 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :default options (options=03303002/ffffffff 
> root_squash   , ----, 34-, UDP, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, a
>
> non_gid=    -2, expire=      60, none, sys)
>
>      5.789818999 395973 TRACE_GANESHA: [svc_15] export_check_access 
> :EXPORT :M_DBG :Final options   (options=023021e0/ffffffff 
> no_root_squash, RWrw, 34-, ---, TCP, ----, No Manage_Gids, -- Deleg, 
> anon_uid=    -2, a
>
> non_gid=    -2, expire=      60, sys)
>
>      5.789840590 395973 TRACE_GANESHA: [svc_15] nfs4_Compound :NFS4 
> :DEBUG :COMPOUND: There are 1 operations, res = 0x7f29fc003150, tag = 
> NO TAG
>
>      5.789855216 395973 TRACE_GANESHA: [svc_15] nfs4_Compound :NFS4 
> :F_DBG :COMPOUND: There are 1 operations nfs4 operations 
> {DESTROY_CLIENTID}
>
>      5.789874099 395973 TRACE_GANESHA: [svc_15] process_one_op :NFS4 
> :DEBUG :Request 0: opcode 57 is OP_DESTROY_CLIENTID
>
>      5.789910130 395973 TRACE_GANESHA: [svc_15] 
> nfs4_op_destroy_clientid :CLIENT ID :DEBUG :DESTROY_CLIENTID 
> clientid=Epoch=0x66a7e0c6 Counter=0x00000002
>
>      5.789930494 395973 TRACE_GANESHA: [svc_15] inc_client_id_ref 
> :CLIENT ID :F_DBG :Increment refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} CONFIRMED 
> Client={0x7f2a200020a0 name=
>
> (44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1} 
> t_delta=0 reservations=0 refcount=2} to 2
>
>      5.789945301 395973 TRACE_GANESHA: [svc_15] inc_client_record_ref 
> :CLIENT ID :F_DBG :Increment refcount {0x7f2a200020a0 name=(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.789960256 395973 TRACE_GANESHA: [svc_15] 
> nfs4_op_destroy_clientid :CLIENT ID :F_DBG :Client Record 
> 0x7f2a200020a0 name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) 
> refcount=2 cr_confirmed_rec=0x7f29fc00
>
> 26d0 cr_unconfirmed_rec=(nil)
>
>      5.789978554 395973 TRACE_GANESHA: [svc_15] 
> nfs4_op_destroy_clientid :CLIENT ID :DEBUG :Removing confirmed 
> clientid 0x7f29fc0026d0 ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} 
> CONFIRMED Client={0x7f2a200020a0
>
> name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2} 
> t_delta=0 reservations=0 refcount=2
>
>      5.790117503 395973 TRACE_GANESHA: [svc_15] fs_rm_clid_impl 
> :CLIENT ID :DEBUG :Removed client dir 
> (/var/lib/nfs/ganesha/v4recov/node0/::ffff:10.11.56.193-(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com))
>
>      5.790141122 395973 TRACE_GANESHA: [svc_15] dec_client_id_ref 
> :CLIENT ID :F_DBG :Decrement refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} EXPIRED 
> Client={0x7f2a200020a0 name=(4
>
> 4:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2} t_delta=0 
> reservations=0 refcount=2} refcount to 1
>
>      5.790156176 395973 TRACE_GANESHA: [svc_15] dec_client_record_ref 
> :CLIENT ID :F_DBG :Decrement refcount now=1 {0x7f2a200020a0 
> name=(44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=2}
>
>      5.790172109 395973 TRACE_GANESHA: [svc_15] dec_client_id_ref 
> :CLIENT ID :F_DBG :Decrement refcount Clientid {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} EXPIRED 
> Client={0x7f2a200020a0 name=(4
>
> 4:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1} t_delta=0 
> reservations=0 refcount=1} refcount to 0
>
>      5.790185156 395973 TRACE_GANESHA: [svc_15] dec_client_id_ref 
> :CLIENT ID :F_DBG :Free Clientid refcount now=0 {0x7f29fc0026d0 
> ClientID={Epoch=0x66a7e0c6 Counter=0x00000002} EXPIRED 
> Client={0x7f2a200020a0 name=(
>
> 44:Linux NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1} t_delta=0 
> reservations=0 refcount=1}
>
>      5.790200509 395973 TRACE_GANESHA: [svc_15] dec_client_record_ref 
> :CLIENT ID :F_DBG :Try to remove {0x7f2a200020a0 name=(44:Linux 
> NFSv4.1 svl-marcrh-node-1.fyre.ibm.com) refcount=1}
>
>      5.790215662 395973 TRACE_GANESHA: [svc_15] dec_client_record_ref 
> :CLIENT ID :F_DBG :Free {0x7f2a200020a0 name=(44:Linux NFSv4.1 
> svl-marcrh-node-1.fyre.ibm.com) refcount=1}
>
>      5.790231007 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Current FH  Len=0 (EMPTY)
>
>      5.790244094 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :F_DBG :Saved FH    Len=0 (EMPTY)
>
>      5.790262649 395973 TRACE_GANESHA: [svc_15] complete_op :NFS4 
> :DEBUG :Status of OP_DESTROY_CLIENTID in position 0 = NFS4_OK, op 
> response size is 4 total response size is 40
>
>      5.790341620 395973 TRACE_GANESHA: [svc_15] 
> release_nfs4_res_compound :NFS4 :F_DBG :Compound Free 0x7f29fc0033a0 
> (resarraylen=1)
>

