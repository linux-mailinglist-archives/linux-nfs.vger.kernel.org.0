Return-Path: <linux-nfs+bounces-20326-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAFVCgE9wWk9RwQAu9opvQ
	(envelope-from <linux-nfs+bounces-20326-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 14:15:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471B2F2A36
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FBA530DF801
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE51A704B;
	Mon, 23 Mar 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAOEg9XT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DED1DA0E1
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271055; cv=none; b=t3nW0SWZUSGNGV0EVJqueZuS78pX9NkWWHSPLN5omTxR2qnfUbQzpQBAXZwKKjxbdNdIZs2FAQCb14ZI9O8P1G8Xd7nX42evixvidOd5M1jLj6tgrq/UhAIH/2rAa3memFM3UvWDHV025fzenEEDYF1I/Q5im3x3cv61kaqKLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271055; c=relaxed/simple;
	bh=EI2BwRhAlnyaD/zwYCGX3wYhE+SsIJnskJ0zBplXBBE=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=QgtluXiC24l8+3I33x76EfaJiWSG3pvTQ4llc5ZFyc6ixmB5jjvIcq9ZSRG56BXCL11MdSu1tK59VzTNZuPGW1afyYr99bRQPOrZhNek6uF4rSWj3LYUTgPa7X2lyBio2CSbY2m7QyfAN1Pno2PtWdAZ58TLA80jzqo1SolHHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAOEg9XT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485358f43e7so5317125e9.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774271052; x=1774875852; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQxRHmKHIlbgXp9p2thT3P7h81ssBY+BxLE+27EI5eU=;
        b=MAOEg9XTqTVC7HeoFhg+ebYIZ0yh596bjcnNk3bA+oiREG/NIXVGx4ClFKwhYy86nA
         YaIxFhkK20XinyqgQN1M7qeTuTR/vhZcX1gWPeQAvUlnF94/yHpJL9AJL7XgWYM0HYBP
         4+KgFZgNaHufnMKdL0KrJOrKOZAUd9jxUjgVHsbu+MhOMqodvxPShceUmdUzf0ekTWQh
         YbAx69tO0j1pxL1N+KHpovkLM74dnAB0biEqLiWeV3z8C9RgQroEt7nWnb7WKybHQB9W
         eNJWrrfj+8SuViPNyftvTc3CfCViAdnTrU9o8DT/VLhaobOnjrXMgLnsWWO7HfCG9QVF
         Ir7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271052; x=1774875852;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQxRHmKHIlbgXp9p2thT3P7h81ssBY+BxLE+27EI5eU=;
        b=j6olC6h0N+MNwhCwYSKyL3VhFnGT9iZzWocJnTGPmqS7i5vCcs3s2FcJHTpZISqlXN
         jp4Qrwpuy85NI/hS5PoxfLRbyPTOA81/oitf0DpwK3Qken+WLi3PqKqSHQfIq4KljCAd
         mEm/o157xIc2az4B+HpIASaqrvp7GM+94IngZxFLxa1mkhJQNFbS+/9+GuYs5OVprOUd
         +4d9546lVAIzYEL59CayAkQn7yHPfqPyxVjz8+ZCz0iguPDpDKgxtFh4D0RlMCZqYwu+
         B1EVs/GUu45IZM4MQbd0Yo7gVA2+WAXj5QPKq1+RB4g3874DWpgA6pYxmu/aUZtMOm9J
         nRKw==
X-Forwarded-Encrypted: i=1; AJvYcCXA740QNsE6ORH5ojmKfnf21bVQ3mABe8NXzZ71EopKdnb3aAsHMCLK5KekcpdUWWNZfdcbLqtJoBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJaY49PU/fjb/HtId5Je76wUWObv/XWUNITtyY8JawrUJ99xQ
	zbK4xa8mVTuPo5JXhmcC+ueprPEECbuW9ITYjyuz5MPnzWfr+IfltGfl
X-Gm-Gg: ATEYQzzyowpjofHe2s8xFimT4aJFVz+mhJNorBVYE/NTdDwDycxWmJu7J4opq8thDEx
	NRskTV2iiFQdi3SUiMPclgg8Q1zIMvJS1LWO8/dtqRy+IwGahcslqeRsgeUmY5d23NX2vT7/RVi
	WWQ9XzYgoIuTuYc+41Bsvg5YKHU3PMHkz0hYJ0v6ypYJWLPh5fhguo++f2zUT5SRRQhkP5QUC/F
	5BoUrmM0E/6xXOx6nUFi0hv/rpIPGCjb5/81udfR4IuKhzsolxF3+u3fAf0ncr4rGk7lZsHmVyc
	T8XndlfDKuju112PPuOqHNpyHXy6EgtgxO75gTAqUaAZiBWvMi3rIo6Pf1QJygyzWpjKCtJlOmd
	Fd9Cl1NqntgjBNcdlY/YlDZVHIyCnsEBeInBF9ORXAOyRprQ6M+iCs/8TRwWyPLVV9BcBu2KuCX
	nuIwJg2+h0bNcU/xW1COC3oX3Y1QNrxF+3lXQob/pGVWKdnARFf7ONxbi3MdO7yIO4VScPqlHDB
	JCq7FgGOfUCPbPfZCadKa7atmV8TcnXcvs=
X-Received: by 2002:a05:600c:4e8e:b0:485:3aa2:da4a with SMTP id 5b1f17b1804b1-486fee00effmr96061055e9.4.1774271051162;
        Mon, 23 Mar 2026 06:04:11 -0700 (PDT)
Received: from smtpclient.apple (walt-26-b2-v4wan-170690-cust332.vm13.cable.virginm.net. [82.19.157.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae619sm30900667f8f.5.2026.03.23.06.04.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 06:04:10 -0700 (PDT)
From: Robert Milkowski <rmilkowski@gmail.com>
Message-Id: <48521545-709C-4ECB-A9C2-9C1DA75DA058@gmail.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_ED54CE7D-648C-494A-B329-EFA02A20EE1B"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] pnfs/filelayout: handle data server op_status errors
Date: Mon, 23 Mar 2026 13:03:59 +0000
In-Reply-To: <9799c4ac60c9732941fe4a67493a45eb9b2686ed.camel@kernel.org>
Cc: anna@kernel.org,
 linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Trond Myklebust <trondmy@kernel.org>
References: <20251209135620.27492-1-rmilkowski@gmail.com>
 <9799c4ac60c9732941fe4a67493a45eb9b2686ed.camel@kernel.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20326-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmilkowski@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 9471B2F2A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Apple-Mail=_ED54CE7D-648C-494A-B329-EFA02A20EE1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Trond,

Apologies for the very long delay in responding.

You're right that v1 overstated the problem. filelayout already gets
NFS-level errors in `task->tk_status` when there is no RPC transport
failure. I've respun this as a cleanup of the existing filelayout =
NFSv4.1
error handling rather than as a parallel op_status-only path.

The new version:
- when `tk_rpc_status =3D=3D 0`, keeps the existing negative =
`task->tk_status`
  handling and only uses `op_status` once `task->tk_status` is =
non-negative;
- keeps transport errors on `task->tk_rpc_status`;
- keeps malformed-reply/decode failures on the existing DS-unavailable =
path;
- preserves the existing DS connection error behaviour (reset to MDS =
rather
  than retrying the same DS RPC);
- handles `NFS4ERR_NOMATCHING_LAYOUT` through the same invalidate/reset =
path.

For evidence, the original investigation had two pieces:
- the blocked task was in the filelayout read path
  (`pnfs_update_layout+0x5e2/0xf50`, =
`fl_pnfs_update_layout.constprop.0`,
  `filelayout_pg_init_read`), and the client was using
  `nfs_layout_nfsv41_files` (`lsmod | grep -i layout` showed
  `nfs_layout_nfsv41_files`);
- in the packet capture, there are 96 DS GETATTR replies of
  `getattr ERROR: unk 60` between 2025-10-27 11:33:18.333378 and
  2025-10-27 11:34:38.718255, from 21 different DS IPs. In
  `include/linux/nfs4.h`, `NFS4ERR_NOMATCHING_LAYOUT` is 10060, so those
  replies are consistent with the DS returning
  `NFS4ERR_NOMATCHING_LAYOUT`, i.e. that the current layout no longer
  matches.

For example, the capture includes:
- `2025-10-27 11:33:18.333378 ... NFS reply xid 1334105934 reply ok 148 =
getattr ERROR: unk 60`
- `2025-10-27 11:33:18.333392 ... NFS reply xid 2507704000 reply ok 148 =
getattr ERROR: unk 60`
- `2025-10-27 11:34:38.718255 ... NFS reply xid 860829781 reply ok 148 =
getattr ERROR: unk 60`

The original incident notes also recorded the same symptom on multiple =
jobs
across multiple clients in the same time window, so this did not look =
like
an isolated single-host event.

That is what led me to respin this along the same NFS-status vs
RPC-status split as 38074de35b01, while keeping filelayout's existing
behaviour for local/decode and DS connection failures.

Testing:
- applies cleanly on current upstream `master`
  (`0e4f8f1a3d081e834be5fd0a62bdb2554fadd307`);
- build-tested there with `x86_64_defconfig`,
  `CONFIG_NFS_FS=3Dm`, `CONFIG_NFS_V4=3Dm`, `CONFIG_PNFS_FILE_LAYOUT=3Dm`,=

  followed by `make -j4`;
- operationally, we've been running a local version with the same
  `tk_status`/`tk_rpc_status`/`op_status` split and
  `NFS4ERR_NOMATCHING_LAYOUT` handling on multiple servers for several
  months, and haven't seen the original hang recur.

See the attached respun v2 patch.


--Apple-Mail=_ED54CE7D-648C-494A-B329-EFA02A20EE1B
Content-Disposition: attachment;
	filename=0001-pnfs-filelayout-handle-data-server-op_status-errors.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-pnfs-filelayout-handle-data-server-op_status-errors.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=201f9849a8291cee861d659eb4ea1b109d696dd3ed=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Robert=20Milkowski=20<rmilkowski@gmail.com>=0A=
Date:=20Mon,=2023=20Mar=202026=2011:26:17=20+0000=0ASubject:=20[PATCH]=20=
pnfs/filelayout:=20handle=20data=20server=20op_status=20errors=0A=0AData=20=
servers=20can=20return=20per-operation=20NFS=20status=20in=20op_status=20=
even=20when=0Athe=20RPC=20transport=20succeeds.=20=
filelayout_async_handle_error()=20currently=0Amixes=20NFS-level=20and=20=
transport-level=20handling=20through=20task->tk_status.=0A=0AModel=20=
this=20on=20the=20NFS-status=20vs=20RPC-status=20split=20in=20=
38074de35b01=0A("NFSv4/flexfiles:=20Fix=20handling=20of=20NFS=20level=20=
errors=20in=20I/O"),=20while=0Akeeping=20filelayout's=20existing=20=
behaviour=20for=20local/decode=20and=20DS=0Aconnection=20failures.=20=
Keep=20the=20existing=20negative=20task->tk_status=20handling=0Afor=20=
successful=20transports,=20use=20op_status=20only=20once=20=
task->tk_status=20is=0Anon-negative,=20and=20use=20tk_rpc_status=20=
strictly=20for=20transport=20errors.=0A=0AWire=20read/write/commit=20=
done=20callbacks=20to=20pass=20op_status=20into=0A=
filelayout_async_handle_error()=20and=20handle=20=
NFS4ERR_NOMATCHING_LAYOUT=20via=0Athe=20existing=20layout=20invalidate=20=
/=20retry-through-MDS=20path.=0A=0ASigned-off-by:=20Robert=20Milkowski=20=
<rmilkowski@gmail.com>=0A---=0A=20fs/nfs/filelayout/filelayout.c=20|=20=
141=20++++++++++++++++++++++-----------=0A=201=20file=20changed,=2096=20=
insertions(+),=2045=20deletions(-)=0A=0Adiff=20--git=20=
a/fs/nfs/filelayout/filelayout.c=20b/fs/nfs/filelayout/filelayout.c=0A=
index=2090a11afa5d05..f941f6fa685e=20100644=0A---=20=
a/fs/nfs/filelayout/filelayout.c=0A+++=20=
b/fs/nfs/filelayout/filelayout.c=0A@@=20-121,6=20+121,7=20@@=20static=20=
void=20filelayout_reset_read(struct=20nfs_pgio_header=20*hdr)=0A=20}=0A=20=
=0A=20static=20int=20filelayout_async_handle_error(struct=20rpc_task=20=
*task,=0A+=09=09=09=09=09=20u32=20op_status,=0A=20=09=09=09=09=09=20=
struct=20nfs4_state=20*state,=0A=20=09=09=09=09=09=20struct=20nfs_client=20=
*clp,=0A=20=09=09=09=09=09=20struct=20pnfs_layout_segment=20*lseg)=0A@@=20=
-129,50=20+130,94=20@@=20static=20int=20=
filelayout_async_handle_error(struct=20rpc_task=20*task,=0A=20=09struct=20=
inode=20*inode=20=3D=20lo->plh_inode;=0A=20=09struct=20=
nfs4_deviceid_node=20*devid=20=3D=20FILELAYOUT_DEVID_NODE(lseg);=0A=20=09=
struct=20nfs4_slot_table=20*tbl=20=3D=20&clp->cl_session->fc_slot_table;=0A=
+=09int=20nfs_err=20=3D=200;=0A+=0A+=09/*=20Only=20trust=20NFS=20status=20=
when=20the=20RPC=20reply=20was=20received.=20*/=0A+=09if=20=
(task->tk_rpc_status=20=3D=3D=200)=20{=0A+=09=09if=20(task->tk_status=20=
<=200)=0A+=09=09=09nfs_err=20=3D=20task->tk_status;=0A+=09=09else=20if=20=
(op_status)=0A+=09=09=09nfs_err=20=3D=20-(int)op_status;=0A+=09}=0A=20=0A=
-=09if=20(task->tk_status=20>=3D=200)=0A-=09=09return=200;=0A-=0A-=09=
switch=20(task->tk_status)=20{=0A-=09/*=20DS=20session=20errors=20*/=0A-=09=
case=20-NFS4ERR_BADSESSION:=0A-=09case=20-NFS4ERR_BADSLOT:=0A-=09case=20=
-NFS4ERR_BAD_HIGH_SLOT:=0A-=09case=20-NFS4ERR_DEADSESSION:=0A-=09case=20=
-NFS4ERR_CONN_NOT_BOUND_TO_SESSION:=0A-=09case=20=
-NFS4ERR_SEQ_FALSE_RETRY:=0A-=09case=20-NFS4ERR_SEQ_MISORDERED:=0A-=09=09=
dprintk("%s=20ERROR=20%d,=20Reset=20session.=20Exchangeid=20"=0A-=09=09=09=
"flags=200x%x\n",=20__func__,=20task->tk_status,=0A-=09=09=09=
clp->cl_exchange_flags);=0A-=09=09=
nfs4_schedule_session_recovery(clp->cl_session,=20task->tk_status);=0A+=09=
switch=20(nfs_err)=20{=0A+=09case=20-NFS4ERR_STALE:=0A+=09=09nfs_err=20=3D=
=20-ESTALE;=0A=20=09=09break;=0A-=09case=20-NFS4ERR_DELAY:=0A-=09case=20=
-NFS4ERR_GRACE:=0A-=09=09rpc_delay(task,=20FILELAYOUT_POLL_RETRY_MAX);=0A=
+=09case=20-NFS4ERR_BADHANDLE:=0A+=09=09nfs_err=20=3D=20-EBADHANDLE;=0A=20=
=09=09break;=0A-=09case=20-NFS4ERR_RETRY_UNCACHED_REP:=0A+=09case=20=
-NFS4ERR_ISDIR:=0A+=09=09nfs_err=20=3D=20-EISDIR;=0A=20=09=09break;=0A-=09=
/*=20Invalidate=20Layout=20errors=20*/=0A-=09case=20-NFS4ERR_ACCESS:=0A-=09=
case=20-NFS4ERR_PNFS_NO_LAYOUT:=0A-=09case=20-ESTALE:=20=20=20=20=20=20=20=
=20=20=20=20/*=20mapped=20NFS4ERR_STALE=20*/=0A-=09case=20-EBADHANDLE:=20=
=20=20=20=20=20=20/*=20mapped=20NFS4ERR_BADHANDLE=20*/=0A-=09case=20=
-EISDIR:=20=20=20=20=20=20=20=20=20=20=20/*=20mapped=20NFS4ERR_ISDIR=20=
*/=0A-=09case=20-NFS4ERR_FHEXPIRED:=0A-=09case=20-NFS4ERR_WRONG_TYPE:=0A=
-=09=09dprintk("%s=20Invalid=20layout=20error=20%d\n",=20__func__,=0A-=09=
=09=09task->tk_status);=0A-=09=09/*=0A-=09=09=20*=20Destroy=20layout=20=
so=20new=20i/o=20will=20get=20a=20new=20layout.=0A-=09=09=20*=20Layout=20=
will=20not=20be=20destroyed=20until=20all=20current=20lseg=0A-=09=09=20*=20=
references=20are=20put.=20Mark=20layout=20as=20invalid=20to=20resend=20=
failed=0A-=09=09=20*=20i/o=20and=20all=20i/o=20waiting=20on=20the=20slot=20=
table=20to=20the=20MDS=20until=0A-=09=09=20*=20layout=20is=20destroyed=20=
and=20a=20new=20valid=20layout=20is=20obtained.=0A-=09=09=20*/=0A-=09=09=
pnfs_destroy_layout(NFS_I(inode));=0A-=09=09=
rpc_wake_up(&tbl->slot_tbl_waitq);=0A-=09=09goto=20reset;=0A+=09}=0A+=0A=
+=09/*=0A+=09=20*=20Preserve=20the=20old=20task->tk_status=20handling=20=
for=20non-NFS=20errors=20after=20a=0A+=09=20*=20successful=20transport.=20=
This=20avoids=20stale=20or=20partially=20decoded=20op_status=0A+=09=20*=20=
values=20overriding=20a=20newer=20local/decode=20failure.=0A+=09=20*/=0A=
+=09if=20(task->tk_rpc_status=20=3D=3D=200=20&&=20task->tk_status=20<=20=
0)=20{=0A+=09=09switch=20(task->tk_status)=20{=0A+=09=09case=20=
-ECONNREFUSED:=0A+=09=09case=20-EHOSTDOWN:=0A+=09=09case=20=
-EHOSTUNREACH:=0A+=09=09case=20-ENETUNREACH:=0A+=09=09case=20-EIO:=0A+=09=
=09case=20-ETIMEDOUT:=0A+=09=09case=20-EPIPE:=0A+=09=09case=20-EPROTO:=0A=
+=09=09case=20-ENODEV:=0A+=09=09=09dprintk("%s=20DS=20reply=20processing=20=
error=20%d\n",=20__func__,=0A+=09=09=09=09task->tk_status);=0A+=09=09=09=
goto=20ds_unavailable;=0A+=09=09}=0A+=09}=0A+=0A+=09if=20(nfs_err=20<=20=
0)=20{=0A+=09=09switch=20(nfs_err)=20{=0A+=09=09/*=20DS=20session=20=
errors=20*/=0A+=09=09case=20-NFS4ERR_BADSESSION:=0A+=09=09case=20=
-NFS4ERR_BADSLOT:=0A+=09=09case=20-NFS4ERR_BAD_HIGH_SLOT:=0A+=09=09case=20=
-NFS4ERR_DEADSESSION:=0A+=09=09case=20=
-NFS4ERR_CONN_NOT_BOUND_TO_SESSION:=0A+=09=09case=20=
-NFS4ERR_SEQ_FALSE_RETRY:=0A+=09=09case=20-NFS4ERR_SEQ_MISORDERED:=0A+=09=
=09=09dprintk("%s=20ERROR=20%d,=20Reset=20session.=20Exchangeid=20"=0A+=09=
=09=09=09"flags=200x%x\n",=20__func__,=20nfs_err,=0A+=09=09=09=09=
clp->cl_exchange_flags);=0A+=09=09=09=
nfs4_schedule_session_recovery(clp->cl_session,=20nfs_err);=0A+=09=09=09=
goto=20out_retry;=0A+=09=09case=20-NFS4ERR_DELAY:=0A+=09=09case=20=
-NFS4ERR_GRACE:=0A+=09=09=09rpc_delay(task,=20=
FILELAYOUT_POLL_RETRY_MAX);=0A+=09=09=09goto=20out_retry;=0A+=09=09case=20=
-NFS4ERR_RETRY_UNCACHED_REP:=0A+=09=09=09goto=20out_retry;=0A+=09=09/*=20=
Invalidate=20Layout=20errors=20*/=0A+=09=09case=20-NFS4ERR_ACCESS:=0A+=09=
=09case=20-NFS4ERR_PNFS_NO_LAYOUT:=0A+=09=09case=20-ESTALE:=20=20=20=20=20=
=20=20=20=20=20=20/*=20mapped=20NFS4ERR_STALE=20*/=0A+=09=09case=20=
-EBADHANDLE:=20=20=20=20=20=20=20/*=20mapped=20NFS4ERR_BADHANDLE=20*/=0A=
+=09=09case=20-EISDIR:=20=20=20=20=20=20=20=20=20=20=20/*=20mapped=20=
NFS4ERR_ISDIR=20*/=0A+=09=09case=20-NFS4ERR_FHEXPIRED:=0A+=09=09case=20=
-NFS4ERR_WRONG_TYPE:=0A+=09=09case=20-NFS4ERR_NOMATCHING_LAYOUT:=0A+=09=09=
=09dprintk("%s=20Invalid=20layout=20error=20%d\n",=20__func__,=0A+=09=09=09=
=09nfs_err);=0A+=09=09=09pnfs_destroy_layout(NFS_I(inode));=0A+=09=09=09=
rpc_wake_up(&tbl->slot_tbl_waitq);=0A+=09=09=09goto=20reset;=0A+=09=09=
default:=0A+=09=09=09goto=20reset;=0A+=09=09}=0A+=09}=0A+=0A+=09if=20=
(task->tk_rpc_status=20=3D=3D=200)=0A+=09=09return=200;=0A+=0A+=09switch=20=
(task->tk_rpc_status)=20{=0A=20=09/*=20RPC=20connection=20errors=20*/=0A=20=
=09case=20-ECONNREFUSED:=0A=20=09case=20-EHOSTDOWN:=0A@@=20-184,7=20=
+229,8=20@@=20static=20int=20filelayout_async_handle_error(struct=20=
rpc_task=20*task,=0A=20=09case=20-EPROTO:=0A=20=09case=20-ENODEV:=0A=20=09=
=09dprintk("%s=20DS=20connection=20error=20%d\n",=20__func__,=0A-=09=09=09=
task->tk_status);=0A+=09=09=09task->tk_rpc_status);=0A+ds_unavailable:=0A=
=20=09=09nfs4_mark_deviceid_unavailable(devid);=0A=20=09=09=
pnfs_error_mark_layout_for_return(inode,=20lseg);=0A=20=09=09=
pnfs_set_lo_fail(lseg);=0A@@=20-193,9=20+239,11=20@@=20static=20int=20=
filelayout_async_handle_error(struct=20rpc_task=20*task,=0A=20=09=
default:=0A=20reset:=0A=20=09=09dprintk("%s=20Retry=20through=20MDS.=20=
Error=20%d\n",=20__func__,=0A-=09=09=09task->tk_status);=0A+=09=09=09=
task->tk_rpc_status=20?=20task->tk_rpc_status=20:=20nfs_err);=0A=20=09=09=
return=20-NFS4ERR_RESET_TO_MDS;=0A=20=09}=0A+=0A+out_retry:=0A=20=09=
task->tk_status=20=3D=200;=0A=20=09return=20-EAGAIN;=0A=20}=0A@@=20=
-208,7=20+256,8=20@@=20static=20int=20filelayout_read_done_cb(struct=20=
rpc_task=20*task,=0A=20=09int=20err;=0A=20=0A=20=09=
trace_nfs4_pnfs_read(hdr,=20task->tk_status);=0A-=09err=20=3D=20=
filelayout_async_handle_error(task,=20hdr->args.context->state,=0A+=09=
err=20=3D=20filelayout_async_handle_error(task,=20hdr->res.op_status,=0A=
+=09=09=09=09=09=20=20=20=20hdr->args.context->state,=0A=20=09=09=09=09=09=
=20=20=20=20hdr->ds_clp,=20hdr->lseg);=0A=20=0A=20=09switch=20(err)=20{=0A=
@@=20-318,7=20+367,8=20@@=20static=20int=20=
filelayout_write_done_cb(struct=20rpc_task=20*task,=0A=20=09int=20err;=0A=
=20=0A=20=09trace_nfs4_pnfs_write(hdr,=20task->tk_status);=0A-=09err=20=3D=
=20filelayout_async_handle_error(task,=20hdr->args.context->state,=0A+=09=
err=20=3D=20filelayout_async_handle_error(task,=20hdr->res.op_status,=0A=
+=09=09=09=09=09=20=20=20=20hdr->args.context->state,=0A=20=09=09=09=09=09=
=20=20=20=20hdr->ds_clp,=20hdr->lseg);=0A=20=0A=20=09switch=20(err)=20{=0A=
@@=20-346,7=20+396,8=20@@=20static=20int=20=
filelayout_commit_done_cb(struct=20rpc_task=20*task,=0A=20=09int=20err;=0A=
=20=0A=20=09trace_nfs4_pnfs_commit_ds(data,=20task->tk_status);=0A-=09=
err=20=3D=20filelayout_async_handle_error(task,=20NULL,=20data->ds_clp,=0A=
+=09err=20=3D=20filelayout_async_handle_error(task,=20=
data->res.op_status,=0A+=09=09=09=09=09=20=20=20=20NULL,=20data->ds_clp,=0A=
=20=09=09=09=09=09=20=20=20=20data->lseg);=0A=20=0A=20=09switch=20(err)=20=
{=0A--=20=0A2.47.1=0A=0A=

--Apple-Mail=_ED54CE7D-648C-494A-B329-EFA02A20EE1B
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




Best regards,
 Robert Milkowski



> On 9 Dec 2025, at 15:33, Trond Myklebust <trondmy@kernel.org> wrote:
> 
> On Tue, 2025-12-09 at 13:56 +0000, Robert Milkowski wrote:
>> Data servers can return NFS-level status in op_status, but the file
>> layout
>> driver only looked at RPC transport errors. That means session
>> errors,
>> layout-invalidating statuses, and retry hints from the DS can be
>> ignored,
>> leading to missed session recovery, stale layouts, or failed retries.
> 
> The task->tk_status can carry NFS level status if there was no RPC
> error. That's why we distinguish between task->tk_status and task-
>> tk_rpc_status (the latter being guaranteed to only carry RPC errors).
> 
> IOW: is there any evidence of what you call out above?
> 
>> 
>> Pass the DS op_status into the async error handler and handle the
>> same set
>> of NFS status codes as flexfiles (see commit 38074de35b01,
>> "NFSv4/flexfiles: Fix handling of NFS level errors in I/O"). Wire the
>> read/write/commit callbacks to propagate op_status so the file layout
>> driver
>> can invalidate layouts, trigger session recovery, or retry as
>> appropriate.
>> 
>> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
>> ---
>>  fs/nfs/filelayout/filelayout.c | 54
>> ++++++++++++++++++++++++++++++++--
>>  1 file changed, 51 insertions(+), 3 deletions(-)
>> 
>> diff --git a/fs/nfs/filelayout/filelayout.c
>> b/fs/nfs/filelayout/filelayout.c
>> index 5c4551117c58..2808baa19f83 100644
>> --- a/fs/nfs/filelayout/filelayout.c
>> +++ b/fs/nfs/filelayout/filelayout.c
>> @@ -121,6 +121,7 @@ static void filelayout_reset_read(struct
>> nfs_pgio_header *hdr)
>>  }
>>  
>>  static int filelayout_async_handle_error(struct rpc_task *task,
>> + u32 op_status,
>>   struct nfs4_state *state,
>>   struct nfs_client *clp,
>>   struct pnfs_layout_segment
>> *lseg)
>> @@ -130,6 +131,48 @@ static int filelayout_async_handle_error(struct
>> rpc_task *task,
>>   struct nfs4_deviceid_node *devid =
>> FILELAYOUT_DEVID_NODE(lseg);
>>   struct nfs4_slot_table *tbl = &clp->cl_session-
>>> fc_slot_table;
>>  
>> + if (op_status) {
>> + switch (op_status) {
>> + case NFS4_OK:
>> + case NFS4ERR_NXIO:
>> + break;
>> + case NFS4ERR_BADSESSION:
>> + case NFS4ERR_BADSLOT:
>> + case NFS4ERR_BAD_HIGH_SLOT:
>> + case NFS4ERR_DEADSESSION:
>> + case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
>> + case NFS4ERR_SEQ_FALSE_RETRY:
>> + case NFS4ERR_SEQ_MISORDERED:
>> + dprintk("%s op_status %u, Reset session.
>> Exchangeid "
>> + "flags 0x%x\n", __func__, op_status,
>> + clp->cl_exchange_flags);
>> + nfs4_schedule_session_recovery(clp-
>>> cl_session,
>> +       op_status);
>> + goto out_retry;
>> + case NFS4ERR_DELAY:
>> + case NFS4ERR_GRACE:
>> + case NFS4ERR_RETRY_UNCACHED_REP:
>> + rpc_delay(task, FILELAYOUT_POLL_RETRY_MAX);
>> + goto out_retry;
>> + case NFS4ERR_ACCESS:
>> + case NFS4ERR_PNFS_NO_LAYOUT:
>> + case NFS4ERR_STALE:
>> + case NFS4ERR_BADHANDLE:
>> + case NFS4ERR_ISDIR:
>> + case NFS4ERR_FHEXPIRED:
>> + case NFS4ERR_WRONG_TYPE:
>> + case NFS4ERR_NOMATCHING_LAYOUT:
>> + case NFSERR_PERM:
>> + dprintk("%s Invalid layout op_status %u\n",
>> __func__,
>> + op_status);
>> + pnfs_destroy_layout(NFS_I(inode));
>> + rpc_wake_up(&tbl->slot_tbl_waitq);
>> + goto reset;
>> + default:
>> + goto reset;
>> + }
>> + }
>> +
>>   if (task->tk_status >= 0)
>>   return 0;
>>  
>> @@ -196,6 +239,8 @@ static int filelayout_async_handle_error(struct
>> rpc_task *task,
>>   task->tk_status);
>>   return -NFS4ERR_RESET_TO_MDS;
>>   }
>> +
>> +out_retry:
>>   task->tk_status = 0;
>>   return -EAGAIN;
>>  }
>> @@ -208,7 +253,8 @@ static int filelayout_read_done_cb(struct
>> rpc_task *task,
>>   int err;
>>  
>>   trace_nfs4_pnfs_read(hdr, task->tk_status);
>> - err = filelayout_async_handle_error(task, hdr->args.context-
>>> state,
>> + err = filelayout_async_handle_error(task, hdr-
>>> res.op_status,
>> +     hdr->args.context-
>>> state,
>>       hdr->ds_clp, hdr->lseg);
>>  
>>   switch (err) {
>> @@ -318,7 +364,8 @@ static int filelayout_write_done_cb(struct
>> rpc_task *task,
>>   int err;
>>  
>>   trace_nfs4_pnfs_write(hdr, task->tk_status);
>> - err = filelayout_async_handle_error(task, hdr->args.context-
>>> state,
>> + err = filelayout_async_handle_error(task, hdr-
>>> res.op_status,
>> +     hdr->args.context-
>>> state,
>>       hdr->ds_clp, hdr->lseg);
>>  
>>   switch (err) {
>> @@ -346,7 +393,8 @@ static int filelayout_commit_done_cb(struct
>> rpc_task *task,
>>   int err;
>>  
>>   trace_nfs4_pnfs_commit_ds(data, task->tk_status);
>> - err = filelayout_async_handle_error(task, NULL, data-
>>> ds_clp,
>> + err = filelayout_async_handle_error(task, data-
>>> res.op_status,
>> +     NULL, data->ds_clp,
>>       data->lseg);
>>  
>>   switch (err) {
>> 
>> base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
> 
> I'd be willing to take something like the above as a cleanup, assuming
> that it replaces the existing handling of NFSv4.1 errors using task-
>> tk_status instead of just adding new cases.
> 
> However I'd want to see evidence that the resulting patch has been
> thoroughly tested before submission, because I currently have no way to
> test it myself.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com


--Apple-Mail=_ED54CE7D-648C-494A-B329-EFA02A20EE1B--

