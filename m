Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7950F461CF9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhK2RvA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 12:51:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57104 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343660AbhK2RtA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 12:49:00 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATH117j024868;
        Mon, 29 Nov 2021 17:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hft/7WxreRtW3KLl0LQRqyoNQyCLMdisz4xPai+FRG4=;
 b=FfLIn8wNRR6cxCntP+Ln4YkrRxgjPUea+UvxN/6jlCKjNH/2Io90tRimurQeTj8UGK8x
 ZE9k4+7sfWRnSrDDs7ps9qabfb0cXjgHvRmLQ/Y+TUabFn47JGvkBLMjzpLTjslq9jPQ
 Ub0+0Oh0+rIoppnbOpkYqEKaQG5ZVjQti50zcs1H3YUs9j9COSgQA3hPkyh3fPv6p1XU
 0PuSJLP9TRArnpqyQdweGpm8XRa29hMURw7ivpWPuEQjpMQniiLrxooM+yWoBWhGn33g
 cguTaUdh5RifPPjOXzmMbEHtiYZNs8vNMv4Jvf1lLxBS8iBR4czdxbbRnkvM5siN7CJr 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueeb26x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 17:45:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATHe2On095587;
        Mon, 29 Nov 2021 17:45:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3020.oracle.com with ESMTP id 3cke4msvb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 17:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZqkUtU3x5l4u5V84LnG32YI8sbSMxLzlS9Bei40IFmbR4g31FdjuyY4slhPD7af+BZW2iZW2yyylyd1AwiSSvuoVmj2Xb4mA02pYsPcKENQX0ccuAVhFI7NiNvrY3dz2RoV0abBkRv62YBILTtqJgCrNHXTgXXBuuGxsWofTxGJFtsQNEOFzvv9mFk+gNeeAVrNn6pfX+z8DNoZj0k6HRGuhic2zhHrjACq7uDdwlabY9h9zS8x74WiI1J4HG3XH6bJHVg9FWRIn5tqIzaTGAZcxWEX3TZShYKZbnMqGjaZmFTaJ799KkNDERs4PNecwx5eJWPySQxxyBqsaEn7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hft/7WxreRtW3KLl0LQRqyoNQyCLMdisz4xPai+FRG4=;
 b=l1JFmYLUot5kz6RU2RYAiEdCkgf7sQth090r3AqoU0C+dBp6LJJl36nXDLw1NPv+4nv/B3UThjuf2gd9Ps5P6LPj9plY7mm6Di9UqCDE4ljzQxyd+GbM3ZuDCvM3uTEfpuHnJ16syvPViunAm4g3ba1WFa6JW05/aMSUiiZXJmILTD0m1kFfguGv+KTH5tS/2kSwre2EaW0/kKfesTrs6tA1n3nui2o+hRgjVkpdjI2abzzQ97hmcccar3NshnOmpbIDhAb6KdB6x6n+tV5RF8NlHLbGVij+73v9h+/AmZTITdSpmpHDqOJhBcKYD4DN70vRtbzssuKsBhMPwZUXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hft/7WxreRtW3KLl0LQRqyoNQyCLMdisz4xPai+FRG4=;
 b=u6JEGyanrykW3k5sa04vR+DrqbiowRiOytxdZR5SJ8DZk8ljL2EANLBpiDVimvXRrZOPNdo3H7xOEoQBmy3Nw43Cf2EetTrhuzbi7Z72kNR2K/e7pP72R59p2SynArWVBClzr4lMV/CzFhOBnsqM+LFuOEoek96zkiizpyKpE4s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3608.namprd10.prod.outlook.com (2603:10b6:a03:120::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 17:45:36 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 17:45:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/20 v3] SUNRPC: clean up server thread management
Thread-Topic: [PATCH 00/20 v3] SUNRPC: clean up server thread management
Thread-Index: AQHX5NzwEbGLOvPS+EmjzIksy7I2AKwayBgA
Date:   Mon, 29 Nov 2021 17:45:36 +0000
Message-ID: <0CF1ED83-FE4A-435F-9403-943D74348696@oracle.com>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ae82805-fe14-44e6-bf48-08d9b3600cc1
x-ms-traffictypediagnostic: BYAPR10MB3608:
x-microsoft-antispam-prvs: <BYAPR10MB360868CB80653B20852E4A7E93669@BYAPR10MB3608.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbRH+PkxwTX/tzx2MxrbZE6zyLzMk3QSmgv85rNvsS39xJlpwfStM73J73dQN7k9pvNoi6hrlRQozh689FZaPKzvWw6U+mZxs8mgRrTzePabKrDpuAnsOkmaxY5pSAbpBluS5e+0aO/bnuksa6y8TtYBCvPNe3VmWTRii2cF4Gvy7dLWs4mgHzT/ezrSazgT9RVdYu495Ovdbc66PKQrPnkar3O+AJ4w7IecMHnISXbHqm6uUv+UWy55nN/lvdA9KLztzoWL42SHKlIb/Tdk7gx+pDXxjAnmWNnSMxfbkHosLhCB+71G0zHJ9/PBd2a8sc+dW7KTb+BofAgrbZZiXLFJog8l/JaXUuG6iu/UjRQdy4SvsTIQYNE+8iEQyCyjMykumCcyVbvStGlSsPqm3QqgO79gzV3WLZbWTJdczmjy5wK3rjS7HaK2qo3znVBj1L8Zy6d+WwODvt0hqQcNIBCsjxcJB/B1WKNpA0P3RwnYX4d7CueiY00q2+66nptguy3YPNydkeE5xV8aGXUmEgwbMlZLSuQGJzkWcYWz1H8uv6EwjldWXGOXhMeoB23SKAg9pGtWWAOS8FbbBAX7Lp0iODkq2msl6hHFe0GR2gpHJ2qV6LN4K4c0NoUVGEzAKG80q6Gfm7gcKUnpj2sG+d6hn0rlJMg1HnKLx+Hj4Y4ToxQe9uYu+iLJggIx9hgPOEdVDJUWBzttNzW/ZlahfPxVqYjekODnazNjKzhcTCaL0mGyaMTeIQMEki/HTUQf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(5660300002)(316002)(71200400001)(6486002)(86362001)(83380400001)(54906003)(508600001)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(38100700002)(6512007)(4326008)(6916009)(91956017)(76116006)(6506007)(26005)(122000001)(53546011)(36756003)(186003)(33656002)(38070700005)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3DDEThc83zE96MkiNrM9bcEG9XDAnZ2sNv2CbcUw3ChshZvzrn1u8EaQaCGF?=
 =?us-ascii?Q?Wu6uEZOZpQn+ws8IzCk2XDbReqdGC6alRckLpHXx5tI/yArPP8rN3SnygWKs?=
 =?us-ascii?Q?6fqY/kw0Nh+vzJ5hkf7A3NuA1gZ6+QpeB+N87RjcDecx23caC9UVPkzPcVvs?=
 =?us-ascii?Q?gGGsdwIsHtHwJeR2RqmEV6/T4We43Eiz2Osh4WJTyH6ujsBa0mdkpPUnjMXf?=
 =?us-ascii?Q?Z1khj1SnQcFjqqRjnGl9pXxSsoqkeG7abbJXSEVQBIVY79azk4PfFZA8Y1WD?=
 =?us-ascii?Q?nTzm+AE8nn9dKrRZWDkkCLOzvgyGq5tdAfXp+0sqy2zEa1js3QTuT4vkz0CF?=
 =?us-ascii?Q?91se8uVvqd/h8HoYqy2nHjAkt045UuxC0XtjLZaUEg3/KgEnj3x5WrmyuEd8?=
 =?us-ascii?Q?HHy7VOQojqFZfPCyzr3KeGsCR2prQz+S/coTg1K2oPrxdESPHUJyTuhbffzM?=
 =?us-ascii?Q?4HT1JI9p9uxv8vgkSkx0BDIQI3G1UyBDcJV09LtdUwldtKKHeAzbuFtnY2jd?=
 =?us-ascii?Q?TR/RqPkFhUN3JyxTqSjVU/Hlzky8n49jhJ5/7MU8p9Mqlrp3xz1dVm1cyGnZ?=
 =?us-ascii?Q?DfcQp8edUNKhPmv7r/k3bLG0FgJUWiMGHJJupyyfS26RVq68LatWv2oema6e?=
 =?us-ascii?Q?DJ2oki2vExBeeqJ7CK6kqdr0Pam8xqLRXW1k4O94XFbluCeFRF9+NEq83ACs?=
 =?us-ascii?Q?m2dyNFfzyALJ4KE/9V1jJ+Y/hv6ngGUNeZSBdM4OjmX2V/napDNAUHPuf81B?=
 =?us-ascii?Q?1/ed91uR+ifV265ij0Yg/6oWSMS8tGdcVQbEv7mmftAyUkqdsT9HFqTnZfF9?=
 =?us-ascii?Q?luBJCkRsdrxSczytY36smEturGl1G929Ut/EgxDU+OEfp2QXsx/sdzKvfmXw?=
 =?us-ascii?Q?0IX4iCg1L1i9wb8MBuidGoD4d33FVQDGi07xHZ5c9eZq2MjVubbUngpbc0ND?=
 =?us-ascii?Q?MRonc+er6sAO9fXWdiwwu9CNMiNgRRtuFaKT12UnqgwlsaoMjbKtxZBZAH9H?=
 =?us-ascii?Q?5I3gK/YuXWYV+YMjiOwZfOBu45UFWgHqjeQdNzpLEH3ewBVeCyHQ8BHLJVaG?=
 =?us-ascii?Q?t5qXSDMT1y6Xg3Own0AsZHe2WdKXbYgdgSMXW+1lyt6tf/0bLhTMm4/T+yRA?=
 =?us-ascii?Q?ChmpioO2qh2vDpvWzeVOh8f4tATeYVoNT9BnGmryBWIuffoROov4AzcrZelJ?=
 =?us-ascii?Q?5WQRmnVtMzbtPJnc0SwTjGhu96KOMEwaCRfZD0AI8ankJvkjQ88+b9PMJXA0?=
 =?us-ascii?Q?Vb9WPybY48pz/C1PZcnboe9ryqqyyoykbUIpCDrDo7N8HnKPW+9trbN7RIwX?=
 =?us-ascii?Q?trfQsTFo2EuKza+4lYjc1zCTRoOPOQC+MKldsNgqd6BHqn2o/TymksGuut91?=
 =?us-ascii?Q?XwB6FlifA1cX71S6CHXUO2AgUWHqjJwn8J/6cP96mJrHD3FrbYjQTLbkfClV?=
 =?us-ascii?Q?bqDBpWTccPcmJ0/XuaCPq1uhy/mTjCq4DNPqDIeSBiNPW2tyYzAUXF0dGOG6?=
 =?us-ascii?Q?g4/YiSZ2YkfcuaWWLSvAn3aVEPK4jpVweWLLMhmkgFB67xnvvCs2LGSoRa3Z?=
 =?us-ascii?Q?P248FlH59Nlyhzrtq1YJEYmuilPko2g0aiG+d5EeP+RItwkPflQA8c1rLqP4?=
 =?us-ascii?Q?WMDm1HUYezbOs2TwAhQDbhA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8B63DA9B2516645B130947E3AAE8A42@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae82805-fe14-44e6-bf48-08d9b3600cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 17:45:36.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqLyeOxcrQAyA/vVXw5erp6xL56yVTlXzVEZCxtr7HlHKHPZ7b6EftvOayJzvcYgk/DR/d4ULwC8Qu0pf7E/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3608
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290083
X-Proofpoint-ORIG-GUID: NrtYAjR_JUim3kJ8XnP1HCOtvfnIgW1u
X-Proofpoint-GUID: NrtYAjR_JUim3kJ8XnP1HCOtvfnIgW1u
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 28, 2021, at 11:51 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> This is v3 of mt server thread management cleanup series.
> changes include:
> - splitting out a couple of patches, and moving simple bugfix to the
>   front.
> - Fixed a bug in previous series where lockd module count was being
>   incremented when the lockd thread started, but not decremented when
>   it exited.
> - minor improvement to patch descriptions.
>=20
> Thanks for the review and testing!
>=20
> NeilBrown
>=20
> ---
>=20
> NeilBrown (20):
>      NFSD: handle errors better in write_ports_addfd()
>      SUNRPC: change svc_get() to return the svc.
>      SUNRPC/NFSD: clean up get/put functions.
>      SUNRPC: stop using ->sv_nrthreads as a refcount
>      nfsd: make nfsd_stats.th_cnt atomic_t
>      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
>      NFSD: narrow nfsd_mutex protection in nfsd thread
>      NFSD: Make it possible to use svc_set_num_threads_sync
>      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
>      NFSD: simplify locking for network notifier.
>      lockd: introduce nlmsvc_serv
>      lockd: simplify management of network status notifiers
>      lockd: move lockd_start_svc() call into lockd_create_svc()
>      lockd: move svc_exit_thread() into the thread
>      lockd: introduce lockd_put()
>      lockd: rename lockd_create_svc() to lockd_get()
>      SUNRPC: move the pool_map definitions (back) into svc.c
>      SUNRPC: always treat sv_nrpools=3D=3D1 as "not pooled"
>      lockd: use svc_set_num_threads() for thread start and stop
>      NFS: switch the callback service back to non-pooled.
>=20
>=20
> fs/lockd/svc.c             | 200 +++++++++++--------------------------
> fs/nfs/callback.c          |  32 ++----
> fs/nfsd/netns.h            |  13 +--
> fs/nfsd/nfsctl.c           |  24 ++---
> fs/nfsd/nfsd.h             |   2 +-
> fs/nfsd/nfssvc.c           | 159 +++++++++++++++--------------
> fs/nfsd/stats.c            |   2 +-
> fs/nfsd/stats.h            |   4 +-
> include/linux/sunrpc/svc.h |  79 ++++++++-------
> net/sunrpc/svc.c           | 175 ++++++++++++++------------------
> 10 files changed, 286 insertions(+), 404 deletions(-)
>=20
> --
> Signature
>=20

Hi Neil-

For broader testing, I've added the patches in this version of the series t=
o
the for-next topic branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


--
Chuck Lever



