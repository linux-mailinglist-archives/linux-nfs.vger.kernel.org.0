Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C83D5B74
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhGZNe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 09:34:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49584 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234909AbhGZNeT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 09:34:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QEBo3K022235;
        Mon, 26 Jul 2021 14:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PgCIDKmOPnb3d2kcp7Z5hdf+3TXglus3ue5GtCkZ82U=;
 b=zh6uiPUfDLSV7GKayjhrd7NCXxcrYbJU21Lc6+LjzTKr0l0CE7L0kBGWSXYBnuvW8ciA
 zLBLDBfJBLVUiAWcTqWx2nuqxv9nEXR5YJs6iJfjPvEtTvWRZKNVrTSQJYWic7WIAz7I
 ml7Q6DmMl7d4vSzRV9obf+n2RcHBwhTEa3CBFrGYsWjgW12JRUyGsQ9i/jI4rWF4H5gQ
 lvt3NU/fGFj2w4BDfRm3hUyP4EK7yOxqBYF1tcAvxLWROPFFWaMrpHOwsAOIk0mBKjIR
 W/sS1aIMS38sJtmoS7MO+68cygt4WHQDB/lqIxo82raUmHUoKEKcpLSjCm/dbjA1uUqh Ag== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PgCIDKmOPnb3d2kcp7Z5hdf+3TXglus3ue5GtCkZ82U=;
 b=n1JV4fAOUJ96RVaBrbljqx/J1h/nzAtadrSLUSHU69/x6ztIYIqf6Qa6vPg0gpo2ahb2
 pjDF2SyOTZS7y9oWGEEgSdNRp6XbG4Y//5Hn9hjiIrsG5LW9k7vBV0AmZ89bKm/ychCk
 Fk4WXnMQMmnDuTMOLzOk6Mw3TpNl4SB4H5ma990VCHTLsB6mZq3KTUNYK2tCoVFr4ah7
 gRIWh9m8yf/GLObAhMEZANVNQ6L0T1Vt/+VlYExYj+XSnmOQO0tdnepaBTSVbmoZJuNn
 eCx/AXaaj02dkWeiTnAYel/7Xlo/YU08i1q0vo/0L08k1K/oKSQftswtQfN0PAAAncbk tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1ktv1bgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:14:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QEAqPm173799;
        Mon, 26 Jul 2021 14:14:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3a07yvjhkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll+MpZTVVTkbKcXrN38Bfxn/6tAdJMQXSiy/quGUQ0e+MOY4toJA+ZMl4bjjhbyHUEqc5v99EQlw/oTSCvuhbBV13gidjBELwLWsS24DlifgxAF+TpBV+uavEnnGxkwcSWKJFGN3HGO8PcBSzfxsuwZJeIBQ5dKutAJJ4xPQ2aovFBvlYzTJvHOA94kAmlcRYZpFb78dsdMD9oJFNFfFYaLdlyU9c8hDzFw6dROpvoeYjymAbBlkDstwbNVdzJtGtjMqUUnpTVdvcJbFLHPhrGvScu0+6Y6w297kdeOJrTw01ds5zi/FzFMhgJ1MZJMpDFC7Omnw3U0Gzwk6AgREHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgCIDKmOPnb3d2kcp7Z5hdf+3TXglus3ue5GtCkZ82U=;
 b=UqA/9tqrok3hMCssf8NQHntRgLAZrtLhb7UEFKHPsoYxgcoebWlm3K8beIgfuzParWVwm6B0Q0KoQcg4amiHwQMzwqsPzwWmR91Esi90ydtwy1rYHZQNA7r4aEUk+dSV6KNotVEHklpaBP1C2QWljdyjYttF2gdPwPd/JQGk856KSCkJBlsoj1W0OdaoAoVR/DjtHOSf2E/pBgkIITvK5Hs9xbEv7O/VgTFhddQp9b8ooi50/7iB7h3rNBdUxRRrAWqUjs/2uq1V3J/iUNI824TrxdnqwENEo4O+TC+fIU0D13Pegw4Ktc5Nh7cnzmqWC37ZMeXJcLPjpSq06CuFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgCIDKmOPnb3d2kcp7Z5hdf+3TXglus3ue5GtCkZ82U=;
 b=MQ+naGvx+zO3nWkErZOYaAKVoSef8OXJaGQkMyuXU1pnbBFC+0HcI8lEK4nownsolLqQOhHjymHGySdqVPvI+ZPD1SuqbELQrlmCulPBUflFWlUBC/zL7dpoOggNF7wbchzeBHehAzF2AsUfUegfFgZCcsjZTqZcnDR2EqM4XdQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 14:14:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 14:14:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Fix potential memory corruption
Thread-Topic: [PATCH 1/2] SUNRPC: Fix potential memory corruption
Thread-Index: AQHXghWxFYZhbtne1EyFuTz/JgrzT6tVTP2A
Date:   Mon, 26 Jul 2021 14:14:43 +0000
Message-ID: <11A2FD92-5090-429E-9E1E-FBC63007BF27@oracle.com>
References: <20210726115924.8576-1-trondmy@kernel.org>
In-Reply-To: <20210726115924.8576-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71971eb-5739-45cf-8186-08d9503fb766
x-ms-traffictypediagnostic: BY5PR10MB4194:
x-microsoft-antispam-prvs: <BY5PR10MB4194C2A32EB09FEF4040EDB693E89@BY5PR10MB4194.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4allsiq/VuYqezPv/z41f+2q5NHc1JkzF+s593dxdfX4Y+uPzWR2gI10dJmIsf67Yf0NgNCQUQasvabZXkFS6jCnhN/QINw5kPrCu6z882RoC5ijbNsN2E8lMrzILWGGtf5XsPAea3sun+ig7V+LvOZoBi9AlOSltXmQoeL7FMU0I1GYoctBy+1dxbogP02ax1qzjq0BzyV7CrqV7koafI8EVVJYibHlCIVI9Atfr4o/1y4Zh0FycIP68iC4jCnIVZLYqaP0NBdynbX8ioz/sGKdfeKnCLDEd8BUfaUiqOCZ1Kpz7XqPXQBFTxnvSaUloU+/NCYLAWrOOyeuLJ8RO0fF1EPDAFmht0PcLSVldBUx9PKKmcmRXLgbvGSdCtVF1OFrai+YzkkaHJZnVrCrgajvVYzt09fo80hJKpxJsw55/2TMIxgsLPDOMPWFkB5YoEGc3X6YGDKaNZMi8ZEdAoATLWFTz0MUFO5JQ5MY4PcK9as2UCWq4aVXp1xrda1KkqvB2ZDgSf4F7gkFnM4VYdnTZ07Qry7xauuN033yiRvIjRhjczCfjbPuelLueoXz5/4oV13k9nLj31sP2NydQiIsivsAqUSy4lpFHDJ0cdJOdoHYbQMSsQQGsHXfD/rjtXHM7OGydZdxybof2CtZjT6a47MSoIS1m+/K2Mxb27BpJn55t0yRTvbuhmG1ygAg8/z3MJEJrqNwHi+wUTdnGxGpURjsY+1W0ubgie3N6KPXnChxJ3U9qweBLHUXJ8NM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(122000001)(5660300002)(86362001)(83380400001)(38100700002)(71200400001)(26005)(6506007)(53546011)(2906002)(33656002)(4326008)(8676002)(36756003)(6916009)(66946007)(66446008)(66476007)(6486002)(66556008)(478600001)(76116006)(64756008)(186003)(8936002)(91956017)(6512007)(316002)(2616005)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bA9nQiezKqfnkjUCGjhkM6kHkB7PPPAhDTI+HYUW4D2WiguGjogF9/adK6f4?=
 =?us-ascii?Q?FYDKRvRN7x01gqNw5Bp+vkcWJIGZaZdldzzG5KUiKtiweZP3t1i+F9qhXZot?=
 =?us-ascii?Q?TDRkUsuHuQu7DP1y5vc9E50MkdPQlB7+G7B0RHf5lq0rBvO54LPs0BNrQvCk?=
 =?us-ascii?Q?bAFFopUs/65XHN9uueKO69El0Q1O109hF0dR5wG19R2qQa71egZGbM5z7sSX?=
 =?us-ascii?Q?b08V4thLxD+AAYzvwlMhc4sv6oCwCgsxXqx7uu4r6nixdZv7gl84JJEs20Bb?=
 =?us-ascii?Q?GrPIx2f8ACOhCYANx5mrFaCR1mTUpBEwNLPjKyyjoJMylDeSvH2MwAhoJBew?=
 =?us-ascii?Q?99C5EYl+C5x525jAe9pwpbvQhOo91Ikj9pw4Ho0uqdVSY9AOK31rfcx91491?=
 =?us-ascii?Q?lJbtjhHEFmRJ/dLOuTIuIMRAHQKdgZt/glRL7pX51aGQMSNeltI5c5UzNaEf?=
 =?us-ascii?Q?I1fqMoftnjGkCGhJTNhydcim+YA9gZFl2KlncpmRdpPSxpnj7HfaZ/74RhM0?=
 =?us-ascii?Q?+8so7D43sPnAk62sMel8q9tzNzDdpsCub8iLAPIqTL8JseXQS7q7pJhaUrG0?=
 =?us-ascii?Q?7VnthO0ETqFZK9eczDouX2DS+iN1m7gsIY6Li6mqA+Zjlt8dpHF+nBxrNp2/?=
 =?us-ascii?Q?aY3aJYjRY83uvKOVNM7PDo6pKuwpAMvD+K9ifGH+kMsZAg7oM8t+d+mz6is8?=
 =?us-ascii?Q?M7WhDRzQuH8lVxqXyScWk0y4OF3qS4wJWOHIexbeFY6z63OXMaci1pHph7Uq?=
 =?us-ascii?Q?pSUjygW+NTMFY7sbi7q0AZyofnaIERLOWKXptfrrUq/wrliAhLFnmX3xDjxq?=
 =?us-ascii?Q?t4mQ76OSMqrtgY3xe3fqWRPi/YmQeaxTJ/xCuvhfrfiwzbL284zBNP9Lhm1X?=
 =?us-ascii?Q?p5xiT+eiggKALnf+mK/tWjq7pjTPbHKh++c4BrKEWXu483oba0GmW1lsSZr9?=
 =?us-ascii?Q?3kEO3VqxUhHan9A9W85PFZ0va03WyO3cmawpoimcEG5aZ2iSHseJ2ASy35cX?=
 =?us-ascii?Q?FtmMMgESXw0aFo7Zf/VATmRkvPDiXlMTrR2b7gvYdTV29p+ArrxMjmjwtpJ6?=
 =?us-ascii?Q?ZmjQDtGYZe1bCtOh39/A96h3uwsc/u5ZweSEWJeNNpAu4ASjNvDLhXU+Y1zR?=
 =?us-ascii?Q?Ra3kY1F5J+AI09y8gNbLHh1cB2NJxPGOC4hIqzgo2oq9hIUQEr64/WLYujdN?=
 =?us-ascii?Q?0z29YwoJXS6Z+j+IuvljPzBz81i11CpbqOHAHxoCglTTADNGUVizL66oUgzi?=
 =?us-ascii?Q?9LfASfE1Ar76ZITgpW8KaAWZ3RHqkGIEhBp4YAsBgTcHJxmqA71cFHnELN2G?=
 =?us-ascii?Q?gbnDneFVCQnUS1hiyxwfx0Do?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07D940F3EB786A47A256F3A594A47FDA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71971eb-5739-45cf-8186-08d9503fb766
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 14:14:43.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDAztt1eDRVa1D/x6hj1U6+zKzwn/jeJbg/NxurgTQQqP76uwRpuRkdDtrGlrPv7u2FVhRQstPbr6IXIDKJZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260081
X-Proofpoint-ORIG-GUID: EGVnrHSQ8mTrz9iuLtmYGAgPeUuZogJJ
X-Proofpoint-GUID: EGVnrHSQ8mTrz9iuLtmYGAgPeUuZogJJ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2021, at 7:59 AM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> We really should not call rpc_wake_up_queued_task_set_status() with
> xprt->snd_task as an argument unless we are certain that is actually an
> rpc_task.
>=20
> Fixes: 0445f92c5d53 ("SUNRPC: Fix disconnection races")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> include/linux/sunrpc/xprt.h | 1 +
> net/sunrpc/xprt.c           | 6 ++++--
> 2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index c8c39f22d3b1..59cd97da895b 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -432,6 +432,7 @@ void			xprt_release_write(struct rpc_xprt *, struct r=
pc_task *);
> #define XPRT_CONGESTED		(9)
> #define XPRT_CWND_WAIT		(10)
> #define XPRT_WRITE_SPACE	(11)
> +#define XPRT_SND_IS_COOKIE	(12)

+1 !!!

However, there are one or more tracepoint call sites that
need to know that snd_task is a valid pointer. As part of
this patch, would you review include/trace/events/sunrpc.h
and check that those are also safe?


> static inline void xprt_set_connected(struct rpc_xprt *xprt)
> {
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index fb6db09725c7..bddd354a0076 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -775,9 +775,9 @@ void xprt_force_disconnect(struct rpc_xprt *xprt)
> 	/* Try to schedule an autoclose RPC call */
> 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) =3D=3D 0)
> 		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
> -	else if (xprt->snd_task)
> +	else if (xprt->snd_task && !test_bit(XPRT_SND_IS_COOKIE, &xprt->state))
> 		rpc_wake_up_queued_task_set_status(&xprt->pending,
> -				xprt->snd_task, -ENOTCONN);
> +						   xprt->snd_task, -ENOTCONN);
> 	spin_unlock(&xprt->transport_lock);
> }
> EXPORT_SYMBOL_GPL(xprt_force_disconnect);
> @@ -866,6 +866,7 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
> 		goto out;
> 	if (xprt->snd_task !=3D task)
> 		goto out;
> +	set_bit(XPRT_SND_IS_COOKIE, &xprt->state);
> 	xprt->snd_task =3D cookie;
> 	ret =3D true;
> out:
> @@ -881,6 +882,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void =
*cookie)
> 	if (!test_bit(XPRT_LOCKED, &xprt->state))
> 		goto out;
> 	xprt->snd_task =3DNULL;
> +	clear_bit(XPRT_SND_IS_COOKIE, &xprt->state);
> 	xprt->ops->release_xprt(xprt, NULL);
> 	xprt_schedule_autodisconnect(xprt);
> out:
> --=20
> 2.31.1
>=20

--
Chuck Lever



