Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6B4C2F37
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiBXPPR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiBXPPP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 10:15:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026C19F45B
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 07:14:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYIuI000620;
        Thu, 24 Feb 2022 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RlskrjzbVq+Vz6cCUkMPSO3WAVORNBwDhx7+TPBRWRI=;
 b=L03XbZnmBLXqi754nsAHIBLYB4z+wqkDzAo9AlIZrv5zYBuIozgW6Iq6sMCpPjwJRrPk
 MQx/UA+cx/quxMy5Fv7bjKN2Rw0XSUJXS2CY44hNTRY733XijCw320m5p2QkBqvxRpjB
 Jz9M/+t0OhPmLkojFjpNPFuKPdNBT3jXOEH6f0E31f971PfHNmS4amZ8IvgWUCadpqGI
 rbusdhsK6NKxyrqaoUq7gca/Ubh2o7nTX+xjNU6WqTNEVorADsL4Sq2LIfTW+UOoeRrg
 HV9ip8MdFi5yQyKnNXOTf6RfToLint4nEMtwrfNlKFPRdTU/ZV86cavnXul628zgV9/A AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6eyh32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:14:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF6X6v180978;
        Thu, 24 Feb 2022 15:14:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3eb483qnka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqLHsivEnwYbmE30KHbFjUHPX7gp/hPMaFE5pVQNqoaDm8ZHAwi0zdy8PRyM36EoK5oxHMZNLOWLGfGG3630tpAFHY8LwlMkBx3eVkWn8qtZI2kGjMl2muQoG3gnd1XYITE8AGwUqSI4mZ0kzp1EHcDZTwz+tZ4WQXBWQWA70aeCZ6Miuw7EcV/kKT9NgMeKpBGHJDLU1NrksP0lAyfYdDX8lZ5BR5RlSMkm+3JJh/O9EitGFZNFyuKgT+5K+sFv+sTOM4lIvbinRyz1eLCFxiJsheLujfBXPUc6A5Xh+9oTNQ0gqqADbgTwNW7i8Mk9ZoARzt2Y1fW43ivrB8ZexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlskrjzbVq+Vz6cCUkMPSO3WAVORNBwDhx7+TPBRWRI=;
 b=iTJAnTH/qgCI+UlBTgJzXZhFh5t5S/ojRJZGsNvq09OA4C5D6pule2uGOX2SeisgATb8a4wt7SxLZ7HZ9ZuScjlzANTu6Vk42p5XkhwQaREEuKxJAS0bg5nhfvj+ypsMRrT4+m/rNX+i/SUsw6EvvL7Z4cBr1StFeCZgOvag5Zktt5nvuRs0lv61DH0OxNjQeUuQ9pWIboRxmE+pgdvcne3dn5bKimWjHiUC8T4OjL4oW7bYoAEp2yORYFGp3FxoyLheZT0vod4pAxwpyHEU8vhudbhjW/5HcvkdfPn3h6ALxTp4N004K4HvglDDYG8G/MFTxrraufa2llNt3mjqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlskrjzbVq+Vz6cCUkMPSO3WAVORNBwDhx7+TPBRWRI=;
 b=vryalTmUgbt/ONKlkoIXzbRMm/aw7a0mKPQttQ9vF/l+ohYAFGPh8uIOZjpAo1j/S2zXOGykuAYzDN4AfMppho/tmgnchGwJLefWrdzEMzpk9rk2LSPbarLanaItGLnZVh3Jb4DtLH3T0n/V8X6eoBXaaFNFXvGM/3Vl2BtXzWY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2586.namprd10.prod.outlook.com (2603:10b6:5:b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 15:14:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 15:14:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Amir Goldstein <amir73il@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: nfsd: unable to allocate nfsd_file_hashtbl
Thread-Topic: nfsd: unable to allocate nfsd_file_hashtbl
Thread-Index: AQHYKWcx6U9uu75K6kWz6WiaaiZmtayiioUAgABFHQA=
Date:   Thu, 24 Feb 2022 15:14:30 +0000
Message-ID: <C5BCCA52-9269-46D2-9972-EF59232B4E24@oracle.com>
References: <CAOQ4uxhYsci9-ADNTH6RZmnzBQoxy0ek4+Hgi9sK8HpF2ftrow@mail.gmail.com>
 <e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org>
In-Reply-To: <e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4fe197c-8a23-431c-025e-08d9f7a85b6d
x-ms-traffictypediagnostic: DM6PR10MB2586:EE_
x-microsoft-antispam-prvs: <DM6PR10MB25860824FD70BAC37043E046933D9@DM6PR10MB2586.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExmZ8CD16xWTGeshVuQLEONvbfRW+ltxA731jfnlcwiPB8m1iGVlcB2mIDoQmeraPaeu5ioI28vA0daIsgdHiYsfNjPpVo7jE2Mm0r8OfWSWj8sbmRFu0QGmg5jJ24Ts5xa1ScM3eR3GjbnvkDVPRribGwnqp15QyElnLT/xqdZxlgD62FTz3KIFd1zTt3vi3g6x1t/K8dajKQtHvNuE8vMhNXEDMmFZwwvB5Vpf182Jh9H5oWfitGdpe6aiPuxgC7iiZ0Y/3udhmz/p3rUr4Ll6T2f15VGI88OZVzUO3MBdtwVkGAG7sovAqgNVw53V2uc7AZH255cSOJkPhkAHDwFSq86ASB4G9AyXH88cqJRejO6vv52pD+xvi8E7+Lwq1J0ZoqGrBX4lEP5Wl7whlQILUFRRfHF3GPOwCRS2+0wpcUgI9W5GwCwzJPv+lmvp1S7CVrcI4zLN8XpN9+wiQhjy+1WqcXLswkMhrr4a1x1h1mOs26iFKp3VpKTcqmUAU1sQRnraGdwQzdIX152Opubxac6oJSOEkaQwNDyFLu7XfCi+g/7OVULrYxR7HpAEvO8AFTNGIITkHzVE1Y7C+KlK2Xm+r7UsQimiA2At0DwMXGjF3el7uLKEyn0SAR62NWOEl7XjEM5pIlKnb5PDJh8UlvuRg3ZhKlGYfjvZi3bQJdhUmhE1zCutO9ZZusc+5+Eg+teTmo+1G8tI/XsEmSnZ4AGc3dyhbyy4fNtcUnGeB4rg6rlBGzko0i8bG/+kzQ7Q+FvYhbtfQikTo46H8TtPEUL8Q5AjdMK1YHBg+HtWMIPJoclYjEddnucjWh6yPZP7yUl2JkUpLZg26DJsLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(36756003)(5660300002)(2906002)(83380400001)(2616005)(8936002)(26005)(38100700002)(186003)(122000001)(38070700005)(53546011)(6506007)(6512007)(966005)(6486002)(508600001)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(91956017)(4326008)(71200400001)(86362001)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yGsLNHGqwQi/v5K7rrSSw32VOpT+Yf8bs6xjDXtb0BXpv8ruyVBbxW+dDRH9?=
 =?us-ascii?Q?obor5jpHgwvNd+BOsQpxyiOMRBtwpnDmDvwuN6KcI4WIkZZpsnCEW1ZX0v1I?=
 =?us-ascii?Q?bFfTHXb6XjRk4lbPFboURADSCMGO7U8gmvVlPrXIPzmWX4wUwKRCVgJEUmza?=
 =?us-ascii?Q?HezYR7Csus4OO/OMx36/fDID5hq8DPLD6SvezzwRAWwkv/bdoSGeSGAXDT/6?=
 =?us-ascii?Q?PGcmc2iQLRslYRcv+RKIG8olOwQheTrfBjRgDAbvrDyXzL/KZc5WfroEnCZf?=
 =?us-ascii?Q?1Wpr8/RFiAY/GPPf3gYqvJZPwZ/7FRTLZMMIvbrvA7h+6hDP2TipdVLYLk0t?=
 =?us-ascii?Q?NHsqZyK43yJdE8qkIYqc7HGx77lF+Y4Yy/R1pcnNG8pr21Vud8/LdiDs94wX?=
 =?us-ascii?Q?R2FHrHENOOB2EjmS1M23x/Q8Rg1bjdmvHnYZVUUx8nOHiMSyigR4uqhZwfek?=
 =?us-ascii?Q?1EqwkoKT7K2bm5RMxqMXPGthBDp5jHnT2S5+NI0xMFPem4kfZxaCDnNSLGma?=
 =?us-ascii?Q?RYyqGB+DVqSE2smUc3w97VO+5bSsicGo/kt1vcHHCohiVeFPbbuhNGfYl5pf?=
 =?us-ascii?Q?JOmyvYebvNLJRo4/n+a6scXZ32l2bTlnuTh31Ln1A+YFXJiouWeLqxYglLME?=
 =?us-ascii?Q?tJpAZdss3mXRjGpTiWAgsslZWiAM43CBnwTCB0PH6LMOP/vKx6rwQwIhQMCd?=
 =?us-ascii?Q?VUHBP9IAXTqb+bVYQsgXKju6ZhS+U5X/V81CmovpBVHQfUq+0YNakyk+HEVS?=
 =?us-ascii?Q?d1jNkMh2ul5dk1Y+0xtJc0YKdD9BYt/nCWA5/jR9TfMAwUgKDu3B3oN81QvJ?=
 =?us-ascii?Q?czR65x0fcFKmCH8rfa/YdcS4hvHxRpSiBjegQFX9GlC4KAkpQ+A7qMdborK6?=
 =?us-ascii?Q?jDvgvMCo6Hwa0xnodTEoyhsP/zV1JuCwwqfb0n3bs+vl3X41H3MWos25KCEs?=
 =?us-ascii?Q?Q0NUYBZdO657YWcsayzNl1rKF/PSxIHrpfVh1mENMHB+K58hFBh0TUpHCOnQ?=
 =?us-ascii?Q?9EsFt3NuoG7aWOGWo6/o4xuJotZxRudNzvrzPmUTk0jhXOUGvfT7bAfVl43v?=
 =?us-ascii?Q?3XUlpqn8bCNhmtFtObOTRSZkwmFmgw6nrdwgQ/Qoo2t8KcZ5+YJq07dhrow+?=
 =?us-ascii?Q?EsdlhMUYT8wW4LRox2UCm0d6vwKEaJ71hBYKP05ny+kH+4dINmXadPMP6xfa?=
 =?us-ascii?Q?IEklYZj4ERY/Vgv4Qt3WbQDJTY6qnlKSvMzEmiEo2X7EDbEmPizZ+Uzgc+WN?=
 =?us-ascii?Q?nhCt6+GXcmbqB0nKqVX50dWxtr8iVgEcwK+T3FnACA/1fUfW3Ft7YJXL4sWU?=
 =?us-ascii?Q?k3vZ8vbni+B6Hy+nfCqWM4xM4WxDpAllxJRYooFKR3aOGT/9zi0uFWeySUWS?=
 =?us-ascii?Q?jnJRTFtMtZPWzs74DavuhtuCsshI03LVHCPNDd1iQ3QIAKF0BJoeE4FzZyeE?=
 =?us-ascii?Q?ne+t5mabbYJoZ+xzCqlsptId8gNlwrWMlleugqHcqw8oPv+j6LccK1XTrwa1?=
 =?us-ascii?Q?jqk835Q8Sdbz+iwxm0/vp8GD2vU794doR6/PYZ1/b9jBnR8pxi64I+SYNG9H?=
 =?us-ascii?Q?4IMC/mIYcurLFMVahhjqZEcsj8boY2FhB7to6K7HFT6fRLXnKZRX+/Hx5L6o?=
 =?us-ascii?Q?f6rAPeg+LcQaKTC0R1kucJE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BFD58F2BBE0DD4FB9C8568F431B49A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fe197c-8a23-431c-025e-08d9f7a85b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 15:14:30.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug1WAcAg4r1v9BcLHwGbmUNc7aJP8Bv7Uxd0Bgi9xQcbDSWqqXcJGEkKJvrEqFLxb6Ha5VCsPHyEg4JYy6PibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2586
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240091
X-Proofpoint-GUID: GwgJUD2pUI7M9ZYWdcCG07AnD7nd8wkU
X-Proofpoint-ORIG-GUID: GwgJUD2pUI7M9ZYWdcCG07AnD7nd8wkU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2022, at 6:07 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2022-02-24 at 12:13 +0200, Amir Goldstein wrote:
>> Hi Jeff,
>>=20
>> I got some reports from customers about failure to allocate the
>> nfsd_file_hashtbl on nfs server restart on a long running system,
>> probably due to memory fragmentation.
>>=20
>> A search in Google for this error message yields several results of
>> similar reports [1][2].
>>=20
>> My question is, does nfsd_file_cache_init() have to be done on server
>> startup?
>>=20
>> Doesn't it make more sense to allocate all the memory pools and
>> hash table on init_nfsd()?
>>=20
>> Thanks,
>> Amir.
>>=20
>> [1] https://unix.stackexchange.com/questions/640534/nfs-cannot-allocate-=
memory
>> [2] https://askubuntu.com/questions/1365821/nfs-crashing-on-ubuntu-serve=
r-20-04
>=20
> That is a big allocation. On my box, nfsd_fcache_bucket is 80 bytes, so
> we end up needing 80 contiguous pages to allocate the whole table. It
> doesn't surprise me that it fails sometimes.
>=20
> We could just allocate it on init_nfsd, but that happens when the module
> is plugged in and we'll lose 80 pages when people plug it in (or build
> it in) and don't actually use nfsd.

Reducing the bucket count might also help, especially if nfb_head
were to be replaced with an rb_tree to allow more items in each
bucket.


> The other option might be to just use kvcalloc? It's not a frequent
> allocation, so I don't think performance would be an issue. We had
> similar reports several years ago with nfsd_reply_cache_init, and using
> kvzalloc ended up taking care of it.

A better long-term solution would be to not require a large
allocation at all. Maybe we could consider some alternative
data structures.


--
Chuck Lever



