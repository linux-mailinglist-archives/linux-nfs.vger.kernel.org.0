Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B1672770
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 19:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjARSqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjARSqO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 13:46:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6CA5B583
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:45:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II3wLX025082;
        Wed, 18 Jan 2023 18:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IqFoTeMEesRrf2p8OakN1MTdcOPOzbpyPhQphdCBoog=;
 b=xeLuJx0G0G2xbAq59CBxVCU9owHnVAvRcPZj0+g0vTo+fkWXqAZy35jNuI/FjNU0gEii
 5ZDMh//8e4/uu28nYx9fv7A8+urkYkRqXGAU/BtEakvKqJzfKCMfZeq0kQhzhgyB7uOa
 Gb3P8VuHhrGextlMnJQ5fllkeigPXCCiLADzfjIj0gwmr0C3T5NtwZM1eDR+lJ5OmuaX
 ldVc4ZpuytQHZ18Y4FLT21oC73AZDN9J1aPBRyou339/Rbx/bRtK7/SfvUJ9UZbqtyCk
 ab9sfH6fvft75ZAY5oMhXh5iWAnLCeBnDdAKFEREBw9N/qi6NpoKm0S1f5RbJJ35Y6XI QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtur94v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 18:45:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IIdaC1029776;
        Wed, 18 Jan 2023 18:45:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6p88874a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 18:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBR16cLU5vLeJkOeSdoV8RvPbYUdf0HxlmDGNgBl4aQyAAcgPuUyNzN2NNPqMpf1Jed37J6uj9VfqwHU/9K/sHPVrVG9RBCSupMaAiMsjoA3Y6+ceThlb2DRF04s8VyH+FMWjD+Io+NPML3zsKvJZef2QIyT+P342qnTcg5W/Ph5oCuqKwfE14piOiMTaJryKYctqOyB9f17vkk9Kh4Hia9NMwUt9rVX+8LgwLcUa5+wxCVHw2gGwaDsyDgmdmp5PC8lcdSQAbvP9R8za5nDxurLpg6taq+nn+AmCcKn0dQyw7jCIn67gc3HDkWSuqV7+JPJmy/KVLOZZ2mnxK8dRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqFoTeMEesRrf2p8OakN1MTdcOPOzbpyPhQphdCBoog=;
 b=FxW6qnhlRimwJtJoh+5h6kO8s/7gDYk58XdD9skKzkmvmwaiKelulA++4tmZT/Km5Q2ZC8wyCQZE8jB1Vu+evrvw/JJewIgtk/Ih7d/d8CSVGaKMtDAc4MqhEwNxAI0XQFTtiW40jgRdtETA7q6iqBC8eGd7R3H4EMcHcAl1sXoTEmr5slI80TfpyNmYgnLZIbofetnNA5laojo+QfZ53JkorBMcwXgNrPYAj+3VjPAM3kugGF8ioD/zvIe7Lm6o43dwSQZ7V/C9iqggxRI9DmetuD9qOI1god5uOruo5TDKHX+5kZM5mNQ+WZ73sdnV+FSvA/0pV7ZPr7Vuf6FRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqFoTeMEesRrf2p8OakN1MTdcOPOzbpyPhQphdCBoog=;
 b=CKTXsCDqfjUoKTSWfjyR3nLivMxhMWr1BBb1PxcKlJ+PUUMI9RFhIa45aV4pW81VDY7tKpfdMhbC0znCn8H734M5CL4/OvXRXWZTBsYtBu3/eCl6ocMB3tNiTr4HT4TM9fUXVK7z76bdDEYUcH8gVBeA+zmX3K2hKw99v8TMnOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5389.namprd10.prod.outlook.com (2603:10b6:5:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 18:45:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 18:45:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] nfsd: don't kill nfsd_files because of lease break
 error
Thread-Topic: [PATCH 3/4] nfsd: don't kill nfsd_files because of lease break
 error
Thread-Index: AQHZIP9hBg2CJmaIdUaleqmmf1lZx66kidwAgAAOOwA=
Date:   Wed, 18 Jan 2023 18:45:32 +0000
Message-ID: <219691FC-FB3A-4DE2-B43A-3000FF69E1C3@oracle.com>
References: <20230105121512.21484-1-jlayton@kernel.org>
 <20230105121512.21484-4-jlayton@kernel.org>
 <951265d3954621086aa00d27c275e1d50d3e9586.camel@kernel.org>
In-Reply-To: <951265d3954621086aa00d27c275e1d50d3e9586.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5389:EE_
x-ms-office365-filtering-correlation-id: b7c6216a-8b94-4d5d-b048-08daf9842e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNi83GbU+r7RgJNy7wejbcCZkTPQlJvBhG+XbwqZUwBjYyJcr8urqVUR3kL/XZ/nsbKUFpSg5AQ0kr4FlQZAY24fAkkP4cwTTHtFzGkaOMI2WvqiUIHN5FWCtBz1yWNqdUfaVQubKD+lc8CfK9XGOFy1gC3RAVWRdv20oQk3uZn/AADGg63vKUQWC58KdxUsGQiUWRdBo6Q6nBZSV7folBncZIo/PMmcJ07xu+gZFnQWO+nCKdyusuaDoVmtpVJt8DydzzPY7CI3eATuampFNT5K+saelBCP3Rj+Srr02REqSpzXr8iO6oUO569K78XzoWxMrGN//03b7WWDOU5dT2NJuz1zaAo9NF0Akkb7Zuc2s2+fUcKwapY4fHDlLKFVuZNixB7nb+Y4rdTPO1mKXAFOcvu/BLTYT3KtBS/TUFnk3wunSJ/458FB3byiPmboQOjOXDn9H7ILdjEShQWho/KZBOGKDvcXrZqrpzGQDWREbgerikgthypIaZXq23G/9E2xMIvRpJupPej6W2LYutngTIqIj0N+8CVTmNBXqA3H1A4uckwuKUkaLF1Z49UViN6jzI/2ggdTgQFppo0EE2ub94ZSlMLxk5MfnHAOYtwbk3EJjNX8H/ymCooHYy6eTi6zYJwRELXRWNc3FcfBsx8HkKoTt02dSuPBkEKSbxoTeTFe1QME9UkQ83ZY5ma1gsuox1et5lN6+fM50JM18s6Vga/8Xgi2Lc64tF8eCRs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(5660300002)(8936002)(83380400001)(41300700001)(38100700002)(122000001)(2906002)(36756003)(38070700005)(86362001)(91956017)(186003)(478600001)(71200400001)(26005)(6512007)(6916009)(6506007)(8676002)(6486002)(33656002)(64756008)(4326008)(316002)(66446008)(53546011)(66476007)(66556008)(2616005)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NEvQU1ivBqF+IzETAja5me7BG3lv+W8g7N1zfsYQRA6xG/hPEolAyaOzRUxQ?=
 =?us-ascii?Q?JzjVMukQuqgVDBmQp4kkqpZu/JcRUfmI+mCxEZCdYJHz3r9OoE4GxrVkm/CV?=
 =?us-ascii?Q?bnYYTgHIF1ht6NWpH+pm86e3zbp4GuwSgDKo7CWtpyYTqZZZ+3aY/lc0bVUX?=
 =?us-ascii?Q?C8fVhEMAGMuyP9n6w/zntyr7uaD8ZgRhh4uTGfrOioaKD2Yf2qB8GFcF34wr?=
 =?us-ascii?Q?Krbj4yA64FWkwuaaBqdr9g73DLqkKC1HXsCEYgGURn0Gn1oU5jLjMKGcNQeP?=
 =?us-ascii?Q?6bbyqPjT6HKkaSInnD79qY9SXYeiQ4D6HxuVAwQx/B3aUYorF5Mh+IUvnc3p?=
 =?us-ascii?Q?J83WRUcFz0ZbzaG2tvSWgOtv3sY891ISCwPQo7GGW2dOLhYXzmRYeyVvb5Yd?=
 =?us-ascii?Q?xnAx5/0cQ3Q7AwLSOG/Kil7/r+83ZDS+PEMmklnmjcemoAxZuTllgjbHbejz?=
 =?us-ascii?Q?ffRI7cC4NpfNkYvm75bN7OPu6TVHRRMRy9w8jlry78SJ1WBqkQU5Qb8Qur9/?=
 =?us-ascii?Q?pNmVcdfTVGVyUgGm1FpLxRZ4QpxLEsEmAgZHEeJByWHBGXEI+VMS2ja9KIwF?=
 =?us-ascii?Q?W7YYcz9p0/d1enPzbyMgGKuxSZzXfZBp/F7zYDTiDawlbDshsqqi3s+XBJPQ?=
 =?us-ascii?Q?ZQN1q01eOs2H2Hhq6C211o9mSyFBdXLwZ1gB/2WW6Yy/sJpjgJrEUHTHFcG0?=
 =?us-ascii?Q?XuMsQUJ50ar1nBX6VYiwXV6T2Cmmn43MuD0H951qsYgEX+RuPQQHR8EGUypy?=
 =?us-ascii?Q?Afd9QXFVmA72mBRkb7ixrZmhoTS0bbw0d7xtVLu2EcJoorVcsD1br/VeLLFJ?=
 =?us-ascii?Q?d5hkMem1T+ELQxHdeyAEPkb8QvfUIqxsn1CoJvqmxklCa2kp2gVA9cHRFKPH?=
 =?us-ascii?Q?X9DcoOUJgDVbWwmeJf+qXzutsLK1HzRPQT/ZlkY2eSGJNYzO+kgY4oEg/GyK?=
 =?us-ascii?Q?e6FAyefF0Rq1kwYpzyL0clSX0UQRQ9WBJZ0Celt7iSgm/WsBP8fVdYkd4K7P?=
 =?us-ascii?Q?NqCOLBxw3CnufvFhnUX1AMA5r84X6nmcZ9D/Zto88EAYzSIrSheB2dDhHpXs?=
 =?us-ascii?Q?1Zg3eeof3WOR0bGois5hpgTPcer+l53goPnDhHaP6JJ6SRzAL5YNMxBKONlo?=
 =?us-ascii?Q?YvAHhiHBbvW18rw093NLK3uLzSTxJDrD6Kl9YizPw1GM7CK1iy21ehlCHe9y?=
 =?us-ascii?Q?IFq94LaS8CQ39qVGnIxnptJFlkpxmGqXRlYnPOwvXk+bRcP0UuGKUUmGWHyv?=
 =?us-ascii?Q?B/K7kSVYK9FTCc9gNnNjr0/0U+1GuNg7Oe77hNFSFMvzGm9M7yeSk3h3f3sG?=
 =?us-ascii?Q?emf+R6bsPQ1RMIxEylsf6/V8BadOUVfL5il3PNqS3qzUUpmnOQn4Mc8wASrF?=
 =?us-ascii?Q?luWyH1uT1jmoNkS4e1mR6HwJd9Wwbd06vp9lsuvLnIh53XxtUj+T1Z6/z+NP?=
 =?us-ascii?Q?HcfGb5i1HI9s+WQCPef9ftIZB4ZhVGU9X3onSe5vEtfnkqS9OhOO1MlNP8/X?=
 =?us-ascii?Q?uCOy45vVYq+i49C7ouSfdxb36/Pio0Mfc0bimZCvOo07QUmxlA4mN0xpYAhX?=
 =?us-ascii?Q?EhX5KuKtGszK/IJ9lithCgYsPdPAuxLsYj9wutQI4oQx03auuaU9wKpGbzSI?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1B0F785A4DC134C9D1915C240D57035@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lasvdFWHEK5WBXYL+e44TX6VZdMmSMakznyObzTfP5xwPEzYYFYQjfGnGa00W3Emx6iKyuBpd7bzu2CAfmA/9WmSJ5AEhXobRtedAHH8NRcr3zmuy6ODubZFym2lSqUxgr1RjOWsUApP3Y6lx0X1mSEHHMZVddPgM39Nxqj9WO6CidT74ZDtTOKJFmLIdPvGBjPBcXeFn8yoqbVoXt/bGudCoHxO/kObLaHfV057N8dWteHF1ZB6wfIApDi1f/pT5L5zi55ymTVXnl5qDtSu8I5DJYigDQp4AX4melHMlZzHwuxRKfeO1JiLGshaKAq4JlvQtOvYs59jHTjPChXz7Wxv/1DwB7hZ8XuqEj6LEERg4JsxRcjIIq85mHfNUslu3/bb1ZJ1JipkxVeonX+SVXbNYSrkIhs+R9BbH2PdVDjaJcosPbsXPo9zLGO2Y1V/lv0XHwFZ65r4dpaNNx75eKEOPFkjhRBEw5C2DmvZYRf3+KQLHs6No+hzoRbde/3kY83avbKaKNpBYXDZbgR7zqzG4WDksstUS1xfEDYsVnllmlLYB/cc4NMm6hduBwuQ4K5yMPMaT6+XgjfNajG730HGjkVFqbN2fKFBAQ4DcP/VsYf7QlRnb/oWiuoXFriI2sd2i1iFgQdcK7FUxHZLy7tAOLUeryC4A+C5Jk/gApAdq6lAwsUxvzEewydFbFBG4G2nMp6fcvPV7bUpJNftrHLOaHWl19XD9Z099+RwBDZIr2isziMTDi0s1lXUdPJpaV2leLW79F0lJ8EfuXCN5SheB2YmMpS4wIcRL7dfxlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c6216a-8b94-4d5d-b048-08daf9842e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 18:45:32.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PBcHMC2U0KPaX4b5cEzsPw8msQkBsaSWmd2GR/fiKos0HHH4MbcFUz9fbLX63mTTLvU/jn5NSQtcEIjzGGN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180158
X-Proofpoint-GUID: 3m8GAS8br3nPgC65anwTDdCdAyI7a5Sm
X-Proofpoint-ORIG-GUID: 3m8GAS8br3nPgC65anwTDdCdAyI7a5Sm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 12:54 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2023-01-05 at 07:15 -0500, Jeff Layton wrote:
>> An error from break_lease is non-fatal, so we needn't destroy the
>> nfsd_file in that case. Just put the reference like we normally would
>> and return the error.
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/filecache.c | 29 +++++++++++++++--------------
>> 1 file changed, 15 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index a67b22579c6e..f0ca9501edb2 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -1113,7 +1113,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>> 	nf =3D nfsd_file_alloc(&key, may_flags);
>> 	if (!nf) {
>> 		status =3D nfserr_jukebox;
>> -		goto out_status;
>> +		goto out;
>> 	}
>>=20
>> 	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
>> @@ -1122,13 +1122,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 	if (likely(ret =3D=3D 0))
>> 		goto open_file;
>>=20
>> -	nfsd_file_slab_free(&nf->nf_rcu);
>> -	nf =3D NULL;
>> 	if (ret =3D=3D -EEXIST)
>> 		goto retry;
>> 	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
>> 	status =3D nfserr_jukebox;
>> -	goto out_status;
>> +	goto construction_err;
>>=20
>> wait_for_construction:
>> 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
>> @@ -1138,28 +1136,24 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
>> 		if (!open_retry) {
>> 			status =3D nfserr_jukebox;
>> -			goto out;
>> +			goto construction_err;
>> 		}
>> 		open_retry =3D false;
>> -		if (refcount_dec_and_test(&nf->nf_ref))
>> -			nfsd_file_free(nf);
>> 		goto retry;
>> 	}
>> -
>> 	this_cpu_inc(nfsd_file_cache_hits);
>>=20
>> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_=
flags));
>> +	if (status !=3D nfs_ok) {
>> +		nfsd_file_put(nf);
>> +		nf =3D NULL;
>> +	}
>> +
>> out:
>> 	if (status =3D=3D nfs_ok) {
>> 		this_cpu_inc(nfsd_file_acquisitions);
>> 		*pnf =3D nf;
>> -	} else {
>> -		if (refcount_dec_and_test(&nf->nf_ref))
>> -			nfsd_file_free(nf);
>> -		nf =3D NULL;
>> 	}
>> -
>> -out_status:
>> 	put_cred(key.cred);
>> 	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
>> 	return status;
>> @@ -1189,6 +1183,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>> 	if (status !=3D nfs_ok)
>> 		nfsd_file_unhash(nf);
>> 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> +	if (status =3D=3D nfs_ok)
>> +		goto out;
>> +
>> +construction_err:
>> +	if (refcount_dec_and_test(&nf->nf_ref))
>> +		nfsd_file_free(nf);
>> +	nf =3D NULL;
>> 	goto out;
>> }
>>=20
>=20
> Chuck, ping?
>=20
> You never responded to this patch and I don't see it in your tree. Any
> thoughts?

It's been in nfsd-next for a bit, but I had to drop a bunch of patches
from nfsd-next until yesterday's -rc PR was applied upstream because
they depended on one of Dai's crasher fixes.

That's been sorted, and I've restored these to nfsd-next.

--
Chuck Lever



