Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE214643EA
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 01:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbhLAAZh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Nov 2021 19:25:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39600 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237423AbhLAAZg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Nov 2021 19:25:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUNRlUA018943;
        Wed, 1 Dec 2021 00:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yJeJEKfj5Bnv6i7nTgNF/DlgzeV/vNyzOx7drtgC7Ts=;
 b=rpPMQoM6cktYVGbpwE1Z5FqDIt285fplyEHH8P45u8zn3m9+0++3M3g4xUhCq7CGXPoj
 2OILUcz3pEtkCwDPL3RLjcfkGpAc0zm0YxaWSPe6UBp33pxAtt4/v+tzuLMrpKDpYrZ4
 WKR9WgrcrI8D6SIc0zUF4mIK4A/7caeLcKEMiiwvFTROGDn+8E1lqHcxa1+K55F1W170
 PpfcToaffNxv2K+LSK3z3Lo/s42DNRw3hP7oo1DDRU0iluwdCcq2/2DssIUsANCRXlVL
 o1i+I9GfhGJGvrePV6IZXLfvzbYB0TnGyuowasvmGV6fTbTdw9CW9tokT3Dwx8DsnGvf Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt85xba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 00:22:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B10Feaa138926;
        Wed, 1 Dec 2021 00:22:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqfmeq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 00:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC0BASVUK8OZff4o7NSi3+AP60MphNClnCkScgXbtmeBhNZW3I7210y9IbV1f8xCbPbltpuqOfgvtF4O2PtnonlDDbre32x/4Sdk4aHjmxfs0BTW143o5pAXA5Of+QR5ciEqqUyYn/gpo53jGER1PVv51PmFb+PJ6nY3yG3gk87NgkmzaMCkiw/PfmhHXDH39AHlkn0Tgytt7ib/UNYAmboJs4fFIIINcG+JUhwxqE0qvl7M+aWCW4nsuy+OnIP0ZuAb+ZBaWm8/rtDCWN/eERKU7syQirMuWPZj8WTg6d3yUkCGBVUfNQy9KX/JGMO/eNleouFUlhjOZ/Yh1OdYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJeJEKfj5Bnv6i7nTgNF/DlgzeV/vNyzOx7drtgC7Ts=;
 b=nUEUS65AAi89KeeAy7s4PBso/n2fxIL6+0QVDLFv6A3XvAw5yBDGodG0n2SUcupWrITr99Z8oPK81R1JngYGjUmSwUC1p24zl/ZdTsoHy9ncLpOWyhe6hImaDqgGCP3kWuB25jSkBI0kTNhO5VT4qv39+zr0fbz0l37pFKu3EPcDLstTew7g+f2Rmw32u+9f/NVcG1yZeW8kjCghRVkhM8HKg02h0H+9JGgJtgviQt2+riB9ffS8wlEmwfwqeVRzgqGTghPh3qzpKqKldAKS7pMxtLE91t1K21Ic6lCkjHSxVQwUvlam7bKH6ZEWwIaaajNwCYivplCYl3raXyFzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJeJEKfj5Bnv6i7nTgNF/DlgzeV/vNyzOx7drtgC7Ts=;
 b=HlqVc6k0CNBPXBYCbUNWm2DDUGfsEfJlJr6YiP+xtd8p4RxePpIoD7Z4A7pQmJeXrffmwq53P65pNA8QirxBgUEdJWD3Q6IPBivm8J3MeQgqVJtnaXrsBX1ECdjfhTAHPK7/7f7h6jJmOCfx02X58kw71SYq1OUQ9JZ7RZR73i8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 00:22:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 00:22:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Fix RCU-related sparse splat
Thread-Topic: [PATCH v2] NFSD: Fix RCU-related sparse splat
Thread-Index: AQHX5XDFTrw4hMDSskyK33okWYrHZawcrx4AgAAMIoCAAAzJgA==
Date:   Wed, 1 Dec 2021 00:22:02 +0000
Message-ID: <2ABC02B1-CE76-422A-B64F-64B108B12C0B@oracle.com>
References: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>
 <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>
 <163831537509.26075.12859361728901873347@noble.neil.brown.name>
In-Reply-To: <163831537509.26075.12859361728901873347@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c6e67f-b274-4c34-9631-08d9b46098dc
x-ms-traffictypediagnostic: BYAPR10MB2693:
x-microsoft-antispam-prvs: <BYAPR10MB269391107813E23A94E27B3793689@BYAPR10MB2693.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +i+WwbMMBp+5BCP5reHoRfsvrlySfSsWXHkVF+WNEW+JoPGAZbHd7SV8gMSbgJLasNsZ+hoSZAheHd3YOTCp31QDtJBWHIurIuJdvFdWAIFcCAn/6I+4w6X1aVKNrdKUT+cqHJKXhIJeDv/qH8+odyLdvTHKhFzw5XzPXIY0w0VdQVSbhBydr5YXFzz+Han7naQKoL4OoP79gzOf6q8V2CRPz58xef0lu2LqHV6dDyj2c6tfjUDtoalsVXuadJrthcp+/u3tBKGebYA+Wn9DOIHmzYzmijkZ1xCqQP5xAKG9oayWjDXQ3BiwTAxRS0ljqCaPU+vW9yULwvmQbZ1lt0B0954ZezpIg1l3ip0eZq7FpQhNnPKDnsbZKT48Fs9LeoMlTOxJ0ca0h2SCTYe1m6CcfeURbedfSF83goptnllTWTYqlv7+xtAe8tMCW7ziH+DHiRZLTEAtekNbWGDx6CzaxXlQsRcePVuMOP9Px9Q6tUABxxztc7cvUCR0QxIJxLpPYU5fQjf26ZMmyUR16PT70JYDlFeoCeGK67VA1astFAfVXXGq/9UKoovYCkXVPR5WsorWdl46vKs9AT8ZcFnfZIs40uBaYV0q7HX0WQPTdpxd9qbZnyKAPiSSvNr7n9tIL0q5i/xKmyISRloWi49d8ZeF3DJK3iLAToCSL9SsC+m130QF+k3UC0TSEUuFv9jnuawYsbKuxW7uES3tIL/LDuVn8ahX1JrwURpL1eRr8WUtTeVyE54HjM4KfFUO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66476007)(91956017)(76116006)(66556008)(8936002)(8676002)(66946007)(36756003)(5660300002)(86362001)(66446008)(2906002)(6512007)(508600001)(83380400001)(38100700002)(26005)(186003)(33656002)(110136005)(53546011)(6506007)(54906003)(38070700005)(71200400001)(122000001)(316002)(4326008)(6486002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7KYrRB7o70n/oaiRmrRqRkpVZqb7wyvOmop3PS/8WuheCcmnHgPyhBGqKl29?=
 =?us-ascii?Q?EqxOXrW47Hu7p4iQV2lUBx6O86SKbv2GbnuyVrYCyohwzwGPfZr5XFBIIehc?=
 =?us-ascii?Q?Yehf4Vtr/t8LEA+Jvsr+oLxgNNYuY0qCclc7kAij5XfTDjb/d3LnghTgRGAs?=
 =?us-ascii?Q?JdTkaioIQv2U5JgIRaeV2IL9m7z/6V3zI2ZRp5DixiarMuBMva+DBzvHuLt7?=
 =?us-ascii?Q?HMKP/JcV9hKwbzq/u2GKTEvRiPqRXIWfA/5hnTc6WBZNwV3Zt/gU7Dih7fze?=
 =?us-ascii?Q?/N/df8NmcM7n3V1PvkJ5nmQyMt1Cqr9i8rnWGt8O7NL2Z0DFSV25IPBpOsQ6?=
 =?us-ascii?Q?HK+toPjPjVPMv+6+r0XInlXH/2PBzCdpyFRn/2hn3iLYGDvSToif5mbrz9ht?=
 =?us-ascii?Q?4lJM3aGpBxc5B1C6PuamW09XGDc0Rwg7UYDnStm3ELtEm2VbQfi5ZmyUUBPB?=
 =?us-ascii?Q?tfglLp8fFsUTtnWHEI9jE/V+mDHoQlH+H012mHxKDFt2/E0YSd2e6nZt5wCk?=
 =?us-ascii?Q?FZYMVBhMqTOOAozFtDF15sU7xo9pyy+ZJ8655lljp1Vi2EjGZKkTFBJ/0qHX?=
 =?us-ascii?Q?qgS6o7NCItFrENlYZf+pK1UtDLilP884ETZwh8xxM4hZUe4uvxsU3iKvakPV?=
 =?us-ascii?Q?7jH7Apzzd6TC3y2otgbBtR+n+1xNtH4qJZDLpfVWjuJ2jRrZZr0wrRHjjUsY?=
 =?us-ascii?Q?1BKnzSuPkitvHf4eFmtuj5RY0uZBo9Ex1srGhZJQOUJ4Q2ZiCW5U6K32iB63?=
 =?us-ascii?Q?SLXGLlm6EMjhUzHG/iez4vaR5iFWq1bvq4APPSHZMJdW6BwRsibdlluChgu/?=
 =?us-ascii?Q?V/ntIFXbo4eFMYVoUOfdR97Inp9iQErQU5GIn/NN3JwZgAjJLIax23fjFmmw?=
 =?us-ascii?Q?l80nt7vZTQKF3Xtxmw5TX2jjQMn46fSvOgXq/fWbKsi63yn0Yi/vB5qqnYJc?=
 =?us-ascii?Q?HuDMCw1AXUJUdHQBYYtvkE73yFy/4wcNzlgfukmP/CnXYCdgHXy1uscAm9Qk?=
 =?us-ascii?Q?ZpK/JFVtr8FBKGKqKHCcoa3n3/4D0BRPl35Od/TedrnzbNkc+OlnRAq3c4ql?=
 =?us-ascii?Q?UTXqxkYDqbwWKpoXUWj8+JOEKXsyPOXIazGESOB4t/7CTS7gn2guQHlVarQF?=
 =?us-ascii?Q?DwrAiBgcVNzFxzi0ZCMD8ItaSEoi3rULAAlSSkSWKE/+0Q7El4G2UaQiCM18?=
 =?us-ascii?Q?y4ZMVZeUgb41pjQ4MtCRZT/NRYqwRnFgOzVjkM9kEW837o2e50Kx13kbxU3G?=
 =?us-ascii?Q?IlSJGGTF9EOo9DhiU+bVTY93Wx9YWKnLpWLmranJvv11p9w7a0txw+eHHCKH?=
 =?us-ascii?Q?mMStNRDLCJc3biJW8L3nV6J418Ufw4MboE/c6dJAvVhiQJTvmki5tK1RSoKI?=
 =?us-ascii?Q?VOeiv6sA5Se4cJz0uTsibcaaW0/rZfEQbL6AiytF7PTVDvCduthxpDzjplVE?=
 =?us-ascii?Q?3Ri7QRk98j6CG6Az8lZoyVoq5k5l2wKvDRV75egBVaB0HRL/MP0msWAVL4Gv?=
 =?us-ascii?Q?PDHN07TV+joI8oq9i/ZrwpbaIvRxP2Q+KCB03fgD01YOlzX00eWBqFRCePvX?=
 =?us-ascii?Q?VriHjLfR7MRyPPHhwarIGctsXayjVUZDBRVAcFz4O45mHIW4Fq8vwaDZREA4?=
 =?us-ascii?Q?ncSfFkC6qHLuuSGEzh4cuJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1155926C9A18141B1E559C86207BD41@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6e67f-b274-4c34-9631-08d9b46098dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 00:22:02.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btuMNv8/+o1GKrlxSTzp+hyzKPFiSh7LDaKn1cBt0eWYAEZroRsZohAxagchqS2GA5qKV3V6M5KgZDsHHCntgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010000
X-Proofpoint-ORIG-GUID: lu53wJbRI2hZIJuttHkj5xnOoJu5Yjy1
X-Proofpoint-GUID: lu53wJbRI2hZIJuttHkj5xnOoJu5Yjy1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2021, at 6:36 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 01 Dec 2021, paulmck@kernel.org wrote:
>> On Mon, Nov 29, 2021 at 01:46:07PM -0500, Chuck Lever wrote:
>>> To address this error:
>>>=20
>>>  CC [M]  fs/nfsd/filecache.o
>>>  CHECK   /home/cel/src/linux/linux/fs/nfsd/filecache.c
>>> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9: error: incompatibl=
e types in comparison expression (different address spaces):
>>> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net [nod=
eref] __rcu *
>>> /home/cel/src/linux/linux/fs/nfsd/filecache.c:772:9:    struct net *
>>>=20
>>> The "net" field in struct nfsd_fcache_disposal is not annotated as
>>> requiring an RCU assignment, so replace the macro that includes an
>>> invocation of rcu_check_sparse() with an equivalent that does not.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> From an RCU perspective:
>>=20
>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>>=20
>> But it would be good to get someone more familiar with the code to
>> look at this.
>=20
> There is a global list of 'struct nfsd_fcache_disposal', potentially one
> for each network namespace.  Each contains a '*net' which is effectively
> an opaque lookup key.  It is never dereferenced - only used to find the
> nfsd_fcache_disposal which matches a given 'struct net *'.
>=20
> The lookup happens under rcu_read_lock().  A 'struct net' is freed after
> a grace period (see cleanup_net() in net_namespace.c) so to ensure the
> lookup doesn't find a false positive - caused by a 'struct net' being
> deallocated and reallocated, it is sufficient to clear the ->net pointer
> while the the net is known to still be active.  At most, a write-barrier
> might be justified.  i.e. smp_store_release(l->net, NULL);

By way of further explanation:

The Documentation/ for RCU (ie, "RCU for Dummies") suggests that
rcu_assign_pointer() is adequate for preventing undesirable
compiler optimizations or CPU load/store reordering.

rcu_assign_pointer() uses WRITE_ONCE for constants like NULL and
smp_store_release() when assigning variable values. I copied the
use of WRITE_ONCE() from rcu_assign_pointer(). So I expect exactly
zero change in behavior or compiled code... (but I should have
checked the generated object to verify that is the case).


> However ... the list of nfsd_fcache_disposal seems unnecessary.
> nfsd has a 'struct nfsd_net' which parallels any interesting 'struct
> net' using the net_generic() framework.
> If the nfs_fcache_disposal were linked from the nfsd_net, there would be
> no need for the list, no need to record the ->net, and not need for the
> code in question here.
> The nfsd_fcache_disposal is destroyed (nfsd_file_cache_shutdown_new())
> before the nfsd_net is destroyed, so there are no lifetime issues with
> keeping the separate list.

Sure. If it makes sense to use nfsd_net instead of a separate data
structure, then that can be made to happen. I would like to hear
from Trond regarding why he felt a separate data structure was
necessary for fcache_disposal.


--
Chuck Lever



