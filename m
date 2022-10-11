Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B145FB2B5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJKM4S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKM4S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 08:56:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6038D915F9
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 05:56:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBcioP011525;
        Tue, 11 Oct 2022 12:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Kkf3f6chpbuWvawytvVFS1slSvj1XbozIFAAB3pm49o=;
 b=B4B6fbIGd8zdtOdrVSyj51ENyRrLCV+vYY5HBQkdeA38n35bw5bWe2OsDRTjcOcd+zPW
 Uq501Z92JrM0S5WAJsG7OFOWfq0kfXjV3ejCWrRCXt2apgaTgY4JCb6o/3CBiM3eoK5E
 +E0cRTDnV3l5TgOZWIKOBqLUBBGBcFfm9QxvxJhhhEU149SgUalpt8qeyYV0Z5zKswDy
 UDl3jjQR8zuS2mnstlzdCWCh661qI1uGnLHFv5vgsRlNWQVHDVKipLWufWl3En0zXaJ7
 ysUq+h+v6zlMo+i0814xFioDgcrudmxcgLe4U99/5G5NktGPsT5yNAKBko9Db+zu7eJf 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3002xktt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 12:56:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BCKhkk002883;
        Tue, 11 Oct 2022 12:56:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn3kpej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 12:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEQjwcEME6QjQ0OTp1V5n2mDjGt1gAPi+gU9cMEwBasAnpgbM2ekdQuuHtnUflME6yxZ5MvjDNqFmtpMuGGJwSjmiIEAxsA2GDgKlHeNNw59pamdwyyNLzfQcsuxm5GfNJQJ4Nh7ZYzCY0FdnQ2hP7jfn2e4h8j/INqNP2gIcC4oCKoTcYs4dR0MVbK2dVEbtRxZ1wmWHlS7zvxykC5hdL+TC64TRQ2uRZOGJiNFVVt+Uufk2A7K4kr0BHj2DsGyyHlusUKnZdLdwiyBgEOMN9BrysJJ4GW0rAoiZZqyklh7AcUqivUgBVzkfk5M+L4Hmr7U3elHaVuEQ76SYO/YMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kkf3f6chpbuWvawytvVFS1slSvj1XbozIFAAB3pm49o=;
 b=EHpgazTu6sjhih2srWI9q9pA9RGGtP+5BmMZuD/45Xuu5YaGAa9pXogob5aPnwTn5pizGG2Yij+L9zY0atjAUzhWEoNaPeylYn7yuiNRxlipBW5mwGV06jYt1FXy+pcjDlDIfok2Cz/fUg9CeMjtLrPcpzx2dn4nhAaBmt+gEzKgnK7T8jULWGEto3/CKRAH/JydGfpUZXjWwfnWLtIjsT7DdAxjS2+IJz/og/D+LVvg2BXi80Ba6wc9kGjsolLfg+eSzjMIKojBOM2qbYo9j8OrwHFlEc9x9p97cDp5om+X0nnOzO7Epu8FFXXO+GkbLTiRc9ftQe2dAaEYm7eNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkf3f6chpbuWvawytvVFS1slSvj1XbozIFAAB3pm49o=;
 b=ZEWMbHwV3+/ub1lVr80KljPS4oCYVfnxg4E7b1nNhQyCxU8UAW01oaAe8JXp3XfFCxjegBTYqRShHRSQva9KN0VtB7PriC/ksQZZIMx3MRx2zHBVpXYOeBLMp8e0BMTDCY88M05aKBUUE+gcwlnjqWOh9zuSLG8dpAOLRVl07tY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 11 Oct
 2022 12:56:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 12:56:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY2Z+f4KLIvxFyZE+pJJ7lJKAPUq4IWjWAgADUNAA=
Date:   Tue, 11 Oct 2022 12:56:09 +0000
Message-ID: <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>
In-Reply-To: <166544739751.14457.9018300177489236723@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6324:EE_
x-ms-office365-filtering-correlation-id: 51624672-62ab-47a6-7188-08daab87f7e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CKoGJWiC491aXBPXT7UwQKDLgvBZuwuWglGQ2n27IjindgpIuMRWU9Upe97BvkL5LZyomjZpskDENouh/BB4E6KdFLRXQmG8SQb6M/Z+qE6Edv3XMxeOVrebozEYdxA1hjQrS4OSgqMBZuelZOS0x9YH/ODgnv9FTYwdxbJlK50WJARLoO6bNJ38Gc/Q4plPVIONaEZ1BlyvPmCeuok+2eNshCIuUb3vG6N8cwjs61VcH/l5TRRmZgdI2yZ5fLVv8HBeT6ft6TQbX6vvOmvShVzsipxzFQeopPaN4eqmDIWQIQpinzn17Vz3kj34JafNjPSKFWv2JR77+3gi5zf+YcBRiCmuU/THKi/DmCaQjyS51JTMN81sFpAAlnBUUlY2mhVOzLz7iBX2PUNWWUUkiDc1egKXeYTzwfuoc7f/LUT+VJmSPvAPhhKUijzvzZGwQoNcAh9dgfZQeASkqQ549BWwhYcmfTWYvVZtzwJzTxHmR6ow4cx9fQEHOZAJeO/A9SqJBKIWd+XvdxssWriQK885emALt8hzT3YmshvKRwjskQJlA6U0qEihimGkEbcPfwenghXI5WdrnfqKdpApKQSlcpMthVNNjspSzk26BIKBymO1cT1WuBWG+7O7U8v2XxmQ6hCDwB/egL1iEDN+uTSewXXAM/GGePUIcP7wPwgTGvnVZn2p80bAnAxEWMzCggf2d4LCYNOcUTqVmfBGsJUKBdPOJLdIEfBnJa1tiDYB4nn/p/nQ3HI+OaY+aaOQUPh7LV1vRHMqcw1HCAKlMf9kt7FQT0pYZpcEP+/9z029/o8RMIHXP4SF0fGcoUKmhzbT1PBcrSsxDRRd4Iw6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(4326008)(83380400001)(38070700005)(26005)(6916009)(76116006)(66946007)(91956017)(53546011)(316002)(186003)(2906002)(6512007)(8676002)(64756008)(86362001)(36756003)(38100700002)(33656002)(122000001)(6506007)(478600001)(66556008)(5660300002)(66476007)(8936002)(966005)(66446008)(6486002)(2616005)(41300700001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ewr8kGHcNmaR+ZALr7Dtx3wMIun8N4Nq4yKM5tlm1AvfLlV405/PCNi++Hpv?=
 =?us-ascii?Q?cUoE2dwoXDrMq8Z6+wWREeGLKFe61Kn+bz+OvmFa58NmUEIbCHe23MfEGmGX?=
 =?us-ascii?Q?bPmlxMvcp7uku3z4dQW1d1NEcPAYiqr4NhtjNo0gOcTTF+Sj0pz1U7+UXXHJ?=
 =?us-ascii?Q?x6lwfcicywfDXmOZu+aAZ2L1ga8tOIZYu1WUiho38ioGm+kMsQlDicItxf4x?=
 =?us-ascii?Q?z94MiWSlrQph8jcg+3zqQ6v7pdd8RPlPO9lXj74r9+TFEVtFE69azaFV5m6n?=
 =?us-ascii?Q?VZkOEE78xFoBlPtsRKwIrC2UhlAfwqKH6ap4C7SzCLSQ7cgKqcdSCFNqound?=
 =?us-ascii?Q?fTYQLOtccPZSTsTR36d9lHh6VfeMAAArictCC+3xdByXz5LqRWC1lAAscmXm?=
 =?us-ascii?Q?JNWqXv6FHZQVq1aygeor6fazC0h1SO2l1XRuu3cKLYHNFQKK/G33yjxZeHL9?=
 =?us-ascii?Q?G+foYoC1QQBommwTQXXUKDYvFmaK/TNxfv6QEBEncXDLaO4ybhDf5WEKX+pZ?=
 =?us-ascii?Q?Oc+Tb/X+hkPue8cW4hzP2uzAwl765TrxVYy4fvgU1TEsVzAMGZUeqtFD2RQ9?=
 =?us-ascii?Q?ZQPxURYzAWaHumnrJb8uLCf81EuDEADYmqJacSgnobUUChM/C6Um8uWDbVSA?=
 =?us-ascii?Q?6cYD0VTiudqsEztV8W3qTbmq9KheR1QVz68BWJSPWyR8PEIDG5XoTq1hay3Z?=
 =?us-ascii?Q?pDjApcR7fq0czZ8UPR7DEmWAr1lzIF/Zmj2EGDLOcBe2d6fEAh+VA+oZ+ext?=
 =?us-ascii?Q?R8VK9vnVGSt6DchtJlCLtwkLAqUpqHN6b1Y/vjGFB1+uDnJa6Ncr4f3XZmyd?=
 =?us-ascii?Q?4jXXPQ6iBt1boLX3jToXNQaMut/u9SfZrWC9mSp6aLbKEoZsa4HtkLC3QhJ/?=
 =?us-ascii?Q?LPpurnfaO0f09wLGrjSFlC7Ng0RE4EGcJll4XgUI6Wus4YdxzZemvZffXexu?=
 =?us-ascii?Q?iZ+yL21HbubqOiVGDfyGluCozgP9EHIKPnSVd3L19PRriMt2VqK5KALWax/b?=
 =?us-ascii?Q?Vawn7eWwYPKeJlYrq6DVpGb4ZKmMwICl/07aremzidUEWUnn44+WniJoYVZC?=
 =?us-ascii?Q?cUDz0Hh1l7+oSrXgE32MusdjVnCgw6SExHFSkekBML0wrAJJ7p0rUY0mP68Q?=
 =?us-ascii?Q?OWMeSAMqvEXm/pmMaPPyyXnxynEfeN318HCpXxPuVxLQsSk0rPBVo/TnNH5f?=
 =?us-ascii?Q?8+uatVx52GG0rFD6YYuZ3DRN8/Jccl4yvcvygeWXxIKfbQFLy/bmyOpZV1ry?=
 =?us-ascii?Q?qY1/VYqJdMUSmAjGWtCFKbqUkBP/9IDaR3lY7oziX7LOsXLAuCg3i12VFXG6?=
 =?us-ascii?Q?8OH8OF96ne3AHdYn38qwH6btrOluGJ3sAVIJAU/p6zgKm2ECUUlZ/ll/B0ga?=
 =?us-ascii?Q?G/kb3ofzTQ3wBm3Um6/oosd9KH7ZVy6zsqAS3gAfIOipcE3Ze3bIItgx9WhF?=
 =?us-ascii?Q?yD3KBKvmh7CdqWU6Ys3cSTlVfIehIOxe6aJj2+1cLuQtllFXYB2Uul44bx9D?=
 =?us-ascii?Q?y7OcZl4BhXseTex3amjv8zv4gGUhqznQCM6TlojnurD4Oy9pCLnmHV7F6u/F?=
 =?us-ascii?Q?kv/IrgFsLlO0k7fhGYPtJ5NpkJe/t+O3WRVGnAJkHLO0T8/QrSWu4G40CDH6?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <512856B508CF584CBE21252CA0352480@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51624672-62ab-47a6-7188-08daab87f7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 12:56:09.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3qi0zxsuw6jydvupE+pYZvNiNnwFbM8dDCebybjSzhX2RLkMlqXHGdPcgDHTzPNngyV7oz52vDsEM9NzBudJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110073
X-Proofpoint-ORIG-GUID: Y6Odrs3Y9N8IES63eXa6njZA5M4aqsj1
X-Proofpoint-GUID: Y6Odrs3Y9N8IES63eXa6njZA5M4aqsj1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Oct 10, 2022, at 8:16 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 07 Oct 2022, Chuck Lever wrote:
>>=20
>> -static unsigned int file_hashval(struct svc_fh *fh)
>> +/*
>> + * The returned hash value is based solely on the address of an in-code
>> + * inode, a pointer to a slab-allocated object. The entropy in such a
>> + * pointer is concentrated in its middle bits.
>=20
> I think you need more justification than that for throwing away some of
> the entropy, even if you don't think it is much.

We might have that justification:

https://lore.kernel.org/linux-nfs/YrUFbLJ5uVbWtZbf@ZenIV/

Actually I believe we are not discarding /any/ entropy in
this function. The bits we discard are invariant.

And, note that this is exactly the same situation we just merged
in the filecache overhaul, and is a common trope amongst other
hash tables that base their function on the inode's address.


> Presumably you think hashing 32 bits is faster than hashing 64 bits.
> Maybe it is, but is it worth it?
>=20
> rhashtable depends heavily on having a strong hash function.  In
> particular if any bucket ends up with more than 16 elements it will
> choose a new seed and rehash.  If you deliberately remove some bits that
> it might have been used to spread those 16 out, then you are asking for
> trouble.
>=20
> We know that two different file handles can refer to the same inode
> ("rarely"), and you deliberately place them in the same hash bucket.
> So if an attacker arranges to access 17 files with the same inode but
> different file handles, then the hashtable will be continuously
> rehashed.
>=20
> The preferred approach when you require things to share a hash chain is
> to use an rhl table.

Again, this is the same situation for the filecache. Do you
believe it is worth reworking that? I'm guessing "yes".


> This allows multiple instances with the same key.
> You would then key the rhl-table with the inode, and search a
> linked-list to find the entry with the desired file handle.  This would
> be no worse in search time than the current code for aliased inodes, but
> less susceptible to attack.
>=20
>> +/**
>> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
>> + * @arg: search criteria
>> + * @ptr: cache item to check
>> + *
>> + * Return values:
>> + *   %0 - Item matches search criteria
>> + *   %1 - Item does not match search criteria
>=20
> I *much* prefer %-ESRCH for "does not match search criteria".  It is
> self-documenting.  Any non-zero value will do.

Noted, but returning 1 appears to be the typical arrangement for
existing obj_cmpfn methods in most other areas.


--
Chuck Lever



