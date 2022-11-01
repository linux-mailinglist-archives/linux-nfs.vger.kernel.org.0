Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173F06154AD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKAWEz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiKAWEe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 18:04:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB41A228
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 15:04:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M47ts000478;
        Tue, 1 Nov 2022 22:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=J0TGRnDDaC1pe3361KCJkXinH8yteT6P/j6VVNIytMg=;
 b=uqMhkwxQAX98AGZQjK0ZTiooETgcU6uvzJ2xhCuv8qGFx6SMWbZ3PNciOtYcLctnrAdz
 6td/uM6JTWqnnqQGN4HLBIoKuOlSz1BAf4p/QZjEiUypja1wU50wJgdq2hMt6ZSuBjq0
 dlfuVnws6kMWsLbKAwbL8XnwDWDQbAR9KY4mfYfxOzaPR+wTpYpOztA9LY5VlHy+WOKB
 wgzUJzjkrd4hCR75YybSS+U9brKcxdbq3/yoNl6qaEDGXrtQIYljyZvqqdp9QyYClNQ9
 8oeZ533+Di9471P379kl+lKMB07XqAbmjtmpBxl+31AOutSoMmlSHAM82+2fTApW5DTy bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty301yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:04:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KZLgB014022;
        Tue, 1 Nov 2022 22:04:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4vj4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNHQrKHg+6QW5FPTsJPZHgTcq9d4uCDxgKl+AOBck94NSYBf/8mp3w/wgGOi4f5bWdsPk+cLFr2Ri+2N9R/o/b7x6Tq6kobT9BZdNQoRo5a5p1pwLhNcUrYqBzWQUgtjINaRvRmMOY2WNzQ3IQlsnVR8NF52bj8xkNXFBE0E1tOh7/4bwElIRtTFlPVt1TVoS/VRhU3sX1ppjANVFxCvMuAl6iy6+a/VVhxTKgCLTVQnIn2MDkylvPNNXPD11hvjIYlJ9RF6Pwj3kJ0cTR7LfioqHWjGzbBxoVdiij4Qtv+i6PPIyrL1p7GGRqm+o1QugmCchhK+PbpsR7SQ/3b8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0TGRnDDaC1pe3361KCJkXinH8yteT6P/j6VVNIytMg=;
 b=SUhNU27XnlprgK2YxNCuzeZr+eW5ZLn2mhrpOyBJhns4w/Q2n013+iwC7/lExH9daIfJe3nwY2C4YDqK96GMN2ftgrolFVeOzUMPyXVdPVJ+8G88dMiB1/oGu2v1qd3nqc+dH3LcD4IRTi46TmleuzX+Cekr9OU2vuwAHHTqpnTqvC19NwKbwfhXIVoYL0IfwRVOFJxUqEEay6uUixFsbTsseRpbc0M+UmApTR0XxWTyuZWSMb9+SiTTObUvIRa62Ci9U34ehCr3tZGnHBtA6UOdRFzKMYNqcOkXGhFKJ8U2zh2GpbNksHwYkJP8QT5T4jzf/6tcCCsNEDlV6lDoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0TGRnDDaC1pe3361KCJkXinH8yteT6P/j6VVNIytMg=;
 b=aZkETObE3jxORChFOAxPKSnL9SqyRhamHG/lSxdcSVrkItenDS5ykxAbwrkx+AC0jBOlZboHfvQ03SiYLU9C05iSO9mAL4z35olcr11t9HYimay157RqwOZnCgUX/6ZLWgIxDffys1CP5+W47RHg/rWKiyyD+YuOE5CQwY7bNFE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 1 Nov
 2022 22:04:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 22:04:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT64qlIAAgAAEOACAAAMKgIAAA/WA
Date:   Tue, 1 Nov 2022 22:04:07 +0000
Message-ID: <486049FC-EC33-457F-A77B-1CFDA37AC779@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
 <166733783854.19313.2332783814411405159@noble.neil.brown.name>
 <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
 <CAA2B2A0-51D0-47E2-A6CB-D89FEA5489EC@oracle.com>
In-Reply-To: <CAA2B2A0-51D0-47E2-A6CB-D89FEA5489EC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB6913:EE_
x-ms-office365-filtering-correlation-id: 2a685bb5-79a5-4224-667b-08dabc54ffa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USOdvQk7mmGyNQsyiXMdkK9Z6MGYK34/bEanb7mhnEwqY160+RYGmOZYFFF80HAu7R1F3xB42gFc72iRUaCQDUyy81u9Gr+7ceZFVPjVozTDJbutxKbLqzwTbi+pMyZjii+mE+udWHrU6YBZ513eliEX/+Gg1GKJV+y4rlsAinkm4y3rF13Bk2ClKnQz5PuRGNU6DFsJooqp+vGQFX8EDxHf87BUk451F1xNfYTj5wyTMTZajYeN70/eKBzimIb/2H877FLRBs4dayEuZL3U0YDiTm3nLwjKQzl1jKxk9vi9J7twJsxw68kOyKLOpVxmXqDLssaapDGuANHH9dzBvLFMb0V5i3XpJa24wXyL7hL1xxYNVHHtJ2u37sjql2xUpTS8bnu8Vt4IahcmzEp1TSAByJAfGUsPukXs62Glp64ReMe0yfSXWnQqJGwvkEZZnngYJxbiwHvyJFb54B0E8NZMyK6RnY79CHRvDo2ozZUt8NTBur615BGtgf0vNCQFgIyekBxm0Bow15VqHtOjwhfDlzVPWV73bV9eEvWUdR110xHYRgVwvoK2Qmvdyk1f5e7XBXIW5sKOZ/No7eACNHbew0d5/5UiDS5XKrrd5WbfOjLouOIJi2tgm1YIQgpBELsi3NXKvt9K++fGTGE9kDUZVxkF8f7TWMQjsbsrusBeEiGYyJCltyxFxZlwRrMeQwR5VoQRamnLcIpkbzlUVGxXCUDVjHGrk4qq7HwOi6sHNkaTYZ/hfx62Fg7F2PDNtFnWpSE73+hqXUbJHsPBu51OFyiswhgXtJPDAEq706o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(5660300002)(110136005)(83380400001)(478600001)(4326008)(2616005)(38100700002)(316002)(76116006)(86362001)(33656002)(38070700005)(8936002)(122000001)(2906002)(66476007)(41300700001)(53546011)(66556008)(91956017)(66446008)(64756008)(66946007)(26005)(6486002)(186003)(8676002)(6512007)(30864003)(6506007)(71200400001)(36756003)(66899015)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HGvcNBCqbzNu6lhktjLfqfqq2NL7ZJS7qe3KTYkJ9COfmgWM8JCZ+o0vrRsi?=
 =?us-ascii?Q?WxH7Zc25ttLvHo7wQR1r2Y7iTGwIBZA7c/gDkLbW9upukUSKNbmBduz19tKS?=
 =?us-ascii?Q?opgXVvwv7jFlZd2SBQomMb2a73NGCNZZ/P36gyxd+k3OzeW32IOV/EoIKHeK?=
 =?us-ascii?Q?8rSBBmsz/H3bNk/Q+MSOinmIYm+mJYSVE6Dhez7odXFraJWNp4a5P1dTQzEM?=
 =?us-ascii?Q?E6iqT0VynuRNXgRt46xNrw17aJt9w/1KBwqt7DngDRAJWzCA0EgdksLG3wAV?=
 =?us-ascii?Q?PSrNgVBqNM3a+4c7RqE/BJSQttEajldIUnp3AmIQyEThyfeeyoWhLec/R7ip?=
 =?us-ascii?Q?Gi1Jf5gle2UefNlgmeiwnnJyqaC5sUU9WQuE0A0AfLNIlQW07plhDgmKS7z2?=
 =?us-ascii?Q?TUDt6oXkyS/cn8HuwKfN9op8TDIh39uiNj0FT5X4l3szWZhQniUCfG1s+0Mm?=
 =?us-ascii?Q?/XTpbctkkwPzSFk8ptPO+ZQMREz5KTrMt80x39SSdZElWdV9G7WF33poxrlu?=
 =?us-ascii?Q?LuobbX9tYrovCA6xTXDYNzaWJEg7ltubjiL10Ji//AaYyl3HFfMxpTzfWd/R?=
 =?us-ascii?Q?zAKOj6l8HYf2AHoszLW2A0+O9TWNiFETTvsdjgPJm/Dz/pWf33bFLZGKqTTj?=
 =?us-ascii?Q?GFRTit5PcU1qq4MRk3tdmbs9oqSiDODiTjMT+XDJcJ+RVkxjX+BGFji+CDuR?=
 =?us-ascii?Q?MH+zXfpqX0rtShiH0mD7+JAgFzzTmRRrr6dfOxIML8e4oL3a5ZMjyEbs0Wqz?=
 =?us-ascii?Q?pzLGKisgrUoetgspStF9j3cEYkMMGhPGDZY9CbB53/oOZFhiK5N5XWEvbQnP?=
 =?us-ascii?Q?qLuVpn2iy2fCyMe99itDsmjkiPeowM3bsGCjM7sLXM5gy3nUxhowwUs7FivQ?=
 =?us-ascii?Q?rLYKU8uxSpMK+XdJ8dJCpHcDKbHsK2kghCKoHlmtqc0gnMRGhb8WcFmeD7Oc?=
 =?us-ascii?Q?2qi/L2mUySfB546oogGJr3382xOJIBw+TUSYgHCv3+5Z3yvgfjqZt9pIiPKW?=
 =?us-ascii?Q?eC0Lv9a5hMcFvRXFIY9KrOcVv/RLbGroXYvQOToXurZLV7/G6iPqzwPUgMvF?=
 =?us-ascii?Q?HUDZYMHsun6yrH6OoW4mV3kQpFOcg+O9/2pgdt4YyxVpeA7hQvIxyejq4sLI?=
 =?us-ascii?Q?2uveyX9ZRovYV6UFAhl3M0TMrOFl7lS+2gWwi6zNCsw2gstlN68QlEaIO1J1?=
 =?us-ascii?Q?ly1NDuCEjEghZenoc/PrlsUMLq0Y7Hs1ZqyojNxxH0LU20rSnU87m6nIXMDP?=
 =?us-ascii?Q?vDoBoIIKU49l3fNwnYVX7dlGRolFBoB8G9gBjub05ensGrsDVskBW98RfYYH?=
 =?us-ascii?Q?wO1Omiagx90R2TccAsLrnnH9hUL7R5Jzdq5Bw5JNEjYph7c9RjwIrJ0tluun?=
 =?us-ascii?Q?ZlW6Ski07qz4Z5nvTlzw3zpjFmu5f0uEoq6G7ssmcx1SWxx59cMrKcRDIU5c?=
 =?us-ascii?Q?v3wHGm+bIBU9Cy8V416TGV9dvEK5t3HkdxziuULNUqV2NinkvqCanAmcV3E4?=
 =?us-ascii?Q?vCG4bfTMppobsZdNgpIA3GLxNF2rTySSda2iMhDJp/efYtxQDAiRNFboH+GP?=
 =?us-ascii?Q?Cgk1dME0R7uLy11biHsrGL4vUYsnkQ8ShmZiE7M13UYa42bvPrg9uLAkTnvM?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D430DBDE95118478A9E515DD1AF022C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a685bb5-79a5-4224-667b-08dabc54ffa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 22:04:07.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsUb5kwxjQ0/4WmxtzVJHJNuYM5tdxo4FA24raNousdf/jqbVOVqj0EN+RjKjTDHcKTN39pAPO1GP2bDFt764Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010151
X-Proofpoint-ORIG-GUID: 5CXJME1LyfstDUDipQ0FrRtws8ExhRmm
X-Proofpoint-GUID: 5CXJME1LyfstDUDipQ0FrRtws8ExhRmm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2022, at 5:49 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>=20
>=20
>> On Nov 1, 2022, at 5:39 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Wed, 2022-11-02 at 08:23 +1100, NeilBrown wrote:
>>> On Wed, 02 Nov 2022, Jeff Layton wrote:
>>>> The filecache refcounting is a bit non-standard for something searchab=
le
>>>> by RCU, in that we maintain a sentinel reference while it's hashed. Th=
is
>>>> in turn requires that we have to do things differently in the "put"
>>>> depending on whether its hashed, which we believe to have led to races=
.
>>>>=20
>>>> There are other problems in here too. nfsd_file_close_inode_sync can e=
nd
>>>> up freeing an nfsd_file while there are still outstanding references t=
o
>>>> it, and there are a number of subtle ToC/ToU races.
>>>>=20
>>>> Rework the code so that the refcount is what drives the lifecycle. Whe=
n
>>>> the refcount goes to zero, then unhash and rcu free the object.
>>>>=20
>>>> With this change, the LRU carries a reference. Take special care to
>>>> deal with it when removing an entry from the list.
>>>=20
>>> The refcounting and lru management all look sane here.
>>>=20
>>> You need to have moved the final put (and corresponding fsync) to
>>> different threads.  I think I see you and Chuck discussing that and I
>>> have no sense of what is "right".=20
>>>=20
>>=20
>> Yeah, this is a tough call. I get Chuck's reticence.
>>=20
>> One thing we could consider is offloading the SYNC_NONE writeback
>> submission to a workqueue. I'm not sure though whether that's a win --
>> it might just add needless context switches. OTOH, that would make it
>> fairly simple to kick off writeback when the REFERENCED flag is cleared,
>> which would probably be the best time to do it.
>=20
> A simple approach might be to just defer freeing of any file opened for
> WRITE to a workqueue, and let one final sync happen there.
>=20
> Splitting this into an async flush followed by a second sync means you're
> walking through the pages of the entire file twice. Only one time is any
> real work done, in most cases.
>=20
> Garbage collection has to visit (and flush out) a lot of files when the
> server is handling a heavy workload. I think that single thread needs
> to run with as little friction as possible, and then defer I/O-related
> work using a multi-threaded model. A work queue would be simple and ideal=
.

fcache_disposal might already do this for us.


>> An entry that ends up being harvested by the LRU scanner is going to be
>> touched by it at least twice: once to clear the REFERENCED flag, and
>> again ~2s later to reap it.
>>=20
>> If we schedule writeback when we clear the flag then we have a pretty
>> good indication that nothing else is going to be using it (though I
>> think we need to clear REFERENCED even when nfsd_file_check_writeback
>> returns true -- I'll fix that in the coming series).
>>=20
>> In any case, I'd probably like to do that sort of change in a separate
>> series after we get the first part sorted.
>=20
> Yep, later works for me too.
>=20
>=20
>>> But it would be nice to explain in
>>> the comment what is being moved and why, so I could then confirm that
>>> the code matches the intent.
>>>=20
>>=20
>> I'm happy to add comments, but I'm a little unclear on what you're
>> confused by here. It's a bit too big of a patch for me to give a full
>> play-by-play description. Can you elaborate on what you'd like to see?
>>=20
>>>>=20
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> fs/nfsd/filecache.c | 247 ++++++++++++++++++++++----------------------
>>>> fs/nfsd/trace.h     |   1 +
>>>> 2 files changed, 123 insertions(+), 125 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index 0bf3727455e2..e67297ad12bf 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -303,8 +303,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, =
unsigned int may)
>>>> 		if (key->gc)
>>>> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>>>> 		nf->nf_inode =3D key->inode;
>>>> -		/* nf_ref is pre-incremented for hash table */
>>>> -		refcount_set(&nf->nf_ref, 2);
>>>> +		refcount_set(&nf->nf_ref, 1);
>>>> 		nf->nf_may =3D key->need;
>>>> 		nf->nf_mark =3D NULL;
>>>> 	}
>>>> @@ -353,24 +352,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
>>>> 	return false;
>>>> }
>>>>=20
>>>> -static bool
>>>> +static void
>>>> nfsd_file_free(struct nfsd_file *nf)
>>>> {
>>>> 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
>>>> -	bool flush =3D false;
>>>>=20
>>>> 	trace_nfsd_file_free(nf);
>>>>=20
>>>> 	this_cpu_inc(nfsd_file_releases);
>>>> 	this_cpu_add(nfsd_file_total_age, age);
>>>>=20
>>>> +	nfsd_file_unhash(nf);
>>>> +
>>>> +	/*
>>>> +	 * We call fsync here in order to catch writeback errors. It's not
>>>> +	 * strictly required by the protocol, but an nfsd_file coule get
>>>> +	 * evicted from the cache before a COMMIT comes in. If another
>>>> +	 * task were to open that file in the interim and scrape the error,
>>>> +	 * then the client may never see it. By calling fsync here, we ensur=
e
>>>> +	 * that writeback happens before the entry is freed, and that any
>>>> +	 * errors reported result in the write verifier changing.
>>>> +	 */
>>>> +	nfsd_file_fsync(nf);
>>>> +
>>>> 	if (nf->nf_mark)
>>>> 		nfsd_file_mark_put(nf->nf_mark);
>>>> 	if (nf->nf_file) {
>>>> 		get_file(nf->nf_file);
>>>> 		filp_close(nf->nf_file, NULL);
>>>> 		fput(nf->nf_file);
>>>> -		flush =3D true;
>>>> 	}
>>>>=20
>>>> 	/*
>>>> @@ -378,10 +388,9 @@ nfsd_file_free(struct nfsd_file *nf)
>>>> 	 * WARN and leak it to preserve system stability.
>>>> 	 */
>>>> 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>>>> -		return flush;
>>>> +		return;
>>>>=20
>>>> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>>>> -	return flush;
>>>> }
>>>>=20
>>>> static bool
>>>> @@ -397,17 +406,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>>>> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>>> }
>>>>=20
>>>> -static void nfsd_file_lru_add(struct nfsd_file *nf)
>>>> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>>> {
>>>> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>>> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
>>>> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>>>> 		trace_nfsd_file_lru_add(nf);
>>>> +		return true;
>>>> +	}
>>>> +	return false;
>>>> }
>>>>=20
>>>> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
>>>> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>>>> {
>>>> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
>>>> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
>>>> 		trace_nfsd_file_lru_del(nf);
>>>> +		return true;
>>>> +	}
>>>> +	return false;
>>>> }
>>>>=20
>>>> struct nfsd_file *
>>>> @@ -418,86 +433,80 @@ nfsd_file_get(struct nfsd_file *nf)
>>>> 	return NULL;
>>>> }
>>>>=20
>>>> -static void
>>>> +/**
>>>> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the dis=
pose list
>>>> + * @nf: nfsd_file to be unhashed and queued
>>>> + * @dispose: list to which it should be queued
>>>> + *
>>>> + * Attempt to unhash a nfsd_file and queue it to the given list. Each=
 file
>>>> + * will have a reference held on behalf of the list. That reference m=
ay come
>>>> + * from the LRU, or we may need to take one. If we can't get a refere=
nce,
>>>> + * ignore it altogether.
>>>> + */
>>>> +static bool
>>>> nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dis=
pose)
>>>> {
>>>> 	trace_nfsd_file_unhash_and_queue(nf);
>>>> 	if (nfsd_file_unhash(nf)) {
>>>> -		/* caller must call nfsd_file_dispose_list() later */
>>>> -		nfsd_file_lru_remove(nf);
>>>> +		/*
>>>> +		 * If we remove it from the LRU, then just use that
>>>> +		 * reference for the dispose list. Otherwise, we need
>>>> +		 * to take a reference. If that fails, just ignore
>>>> +		 * the file altogether.
>>>> +		 */
>>>> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
>>>> +			return false;
>>>> 		list_add(&nf->nf_lru, dispose);
>>>> +		return true;
>>>> 	}
>>>> +	return false;
>>>> }
>>>>=20
>>>> -static void
>>>> -nfsd_file_put_noref(struct nfsd_file *nf)
>>>> -{
>>>> -	trace_nfsd_file_put(nf);
>>>> -
>>>> -	if (refcount_dec_and_test(&nf->nf_ref)) {
>>>> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
>>>> -		nfsd_file_lru_remove(nf);
>>>> -		nfsd_file_free(nf);
>>>> -	}
>>>> -}
>>>> -
>>>> -static void
>>>> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
>>>> -{
>>>> -	if (nfsd_file_unhash(nf))
>>>> -		nfsd_file_put_noref(nf);
>>>> -}
>>>> -
>>>> +/**
>>>> + * nfsd_file_put - put the reference to a nfsd_file
>>>> + * @nf: nfsd_file of which to put the reference
>>>> + *
>>>> + * Put a reference to a nfsd_file. In the v4 case, we just put the
>>>> + * reference immediately. In the GC case, if the reference would be
>>>> + * the last one, the put it on the LRU instead to be cleaned up later=
.
>>>> + */
>>>> void
>>>> nfsd_file_put(struct nfsd_file *nf)
>>>> {
>>>> 	might_sleep();
>>>> +	trace_nfsd_file_put(nf);
>>>>=20
>>>> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
>>>> -		nfsd_file_lru_add(nf);
>>>> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>>>> -		nfsd_file_unhash_and_put(nf);
>>>> -
>>>> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>> -		nfsd_file_fsync(nf);
>>>> -		nfsd_file_put_noref(nf);
>>>> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>>>> -		nfsd_file_put_noref(nf);
>>>> -		nfsd_file_schedule_laundrette();
>>>> -	} else
>>>> -		nfsd_file_put_noref(nf);
>>>> -}
>>>> -
>>>> -static void
>>>> -nfsd_file_dispose_list(struct list_head *dispose)
>>>> -{
>>>> -	struct nfsd_file *nf;
>>>> -
>>>> -	while(!list_empty(dispose)) {
>>>> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>>> -		list_del_init(&nf->nf_lru);
>>>> -		nfsd_file_fsync(nf);
>>>> -		nfsd_file_put_noref(nf);
>>>> +	/*
>>>> +	 * The HASHED check is racy. We may end up with the occasional
>>>> +	 * unhashed entry on the LRU, but they should get cleaned up
>>>> +	 * like any other.
>>>> +	 */
>>>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
>>>> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>> +		/*
>>>> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
>>>> +		 * it to the LRU. If the add to the LRU fails, just put it as
>>>> +		 * usual.
>>>> +		 */
>>>> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
>>>> +			nfsd_file_schedule_laundrette();
>>>> +			return;
>>>> +		}
>>>> 	}
>>>> +	if (refcount_dec_and_test(&nf->nf_ref))
>>>> +		nfsd_file_free(nf);
>>>> }
>>>>=20
>>>> static void
>>>> -nfsd_file_dispose_list_sync(struct list_head *dispose)
>>>> +nfsd_file_dispose_list(struct list_head *dispose)
>>>> {
>>>> -	bool flush =3D false;
>>>> 	struct nfsd_file *nf;
>>>>=20
>>>> 	while(!list_empty(dispose)) {
>>>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>>> 		list_del_init(&nf->nf_lru);
>>>> -		nfsd_file_fsync(nf);
>>>> -		if (!refcount_dec_and_test(&nf->nf_ref))
>>>> -			continue;
>>>> -		if (nfsd_file_free(nf))
>>>> -			flush =3D true;
>>>> +		nfsd_file_free(nf);
>>>> 	}
>>>> -	if (flush)
>>>> -		flush_delayed_fput();
>>>> }
>>>>=20
>>>> static void
>>>> @@ -567,21 +576,8 @@ nfsd_file_lru_cb(struct list_head *item, struct l=
ist_lru_one *lru,
>>>> 	struct list_head *head =3D arg;
>>>> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>>>>=20
>>>> -	/*
>>>> -	 * Do a lockless refcount check. The hashtable holds one reference, =
so
>>>> -	 * we look to see if anything else has a reference, or if any have
>>>> -	 * been put since the shrinker last ran. Those don't get unhashed an=
d
>>>> -	 * released.
>>>> -	 *
>>>> -	 * Note that in the put path, we set the flag and then decrement the
>>>> -	 * counter. Here we check the counter and then test and clear the fl=
ag.
>>>> -	 * That order is deliberate to ensure that we can do this locklessly=
.
>>>> -	 */
>>>> -	if (refcount_read(&nf->nf_ref) > 1) {
>>>> -		list_lru_isolate(lru, &nf->nf_lru);
>>>> -		trace_nfsd_file_gc_in_use(nf);
>>>> -		return LRU_REMOVED;
>>>> -	}
>>>> +	/* We should only be dealing with GC entries here */
>>>> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>>>>=20
>>>> 	/*
>>>> 	 * Don't throw out files that are still undergoing I/O or
>>>> @@ -592,40 +588,30 @@ nfsd_file_lru_cb(struct list_head *item, struct =
list_lru_one *lru,
>>>> 		return LRU_SKIP;
>>>> 	}
>>>>=20
>>>> +	/* If it was recently added to the list, skip it */
>>>> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>>>> 		trace_nfsd_file_gc_referenced(nf);
>>>> 		return LRU_ROTATE;
>>>> 	}
>>>>=20
>>>> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>> -		trace_nfsd_file_gc_hashed(nf);
>>>> -		return LRU_SKIP;
>>>> +	/*
>>>> +	 * Put the reference held on behalf of the LRU. If it wasn't the las=
t
>>>> +	 * one, then just remove it from the LRU and ignore it.
>>>> +	 */
>>>> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
>>>> +		trace_nfsd_file_gc_in_use(nf);
>>>> +		list_lru_isolate(lru, &nf->nf_lru);
>>>> +		return LRU_REMOVED;
>>>> 	}
>>>>=20
>>>> +	/* Refcount went to zero. Unhash it and queue it to the dispose list=
 */
>>>> +	nfsd_file_unhash(nf);
>>>> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
>>>> 	this_cpu_inc(nfsd_file_evictions);
>>>> 	trace_nfsd_file_gc_disposed(nf);
>>>> 	return LRU_REMOVED;
>>>> }
>>>>=20
>>>> -/*
>>>> - * Unhash items on @dispose immediately, then queue them on the
>>>> - * disposal workqueue to finish releasing them in the background.
>>>> - *
>>>> - * cel: Note that between the time list_lru_shrink_walk runs and
>>>> - * now, these items are in the hash table but marked unhashed.
>>>> - * Why release these outside of lru_cb ? There's no lock ordering
>>>> - * problem since lru_cb currently takes no lock.
>>>> - */
>>>> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
>>>> -{
>>>> -	struct nfsd_file *nf;
>>>> -
>>>> -	list_for_each_entry(nf, dispose, nf_lru)
>>>> -		nfsd_file_hash_remove(nf);
>>>> -	nfsd_file_dispose_list_delayed(dispose);
>>>> -}
>>>> -
>>>> static void
>>>> nfsd_file_gc(void)
>>>> {
>>>> @@ -635,7 +621,7 @@ nfsd_file_gc(void)
>>>> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>>> 			    &dispose, list_lru_count(&nfsd_file_lru));
>>>> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>>> -	nfsd_file_gc_dispose_list(&dispose);
>>>> +	nfsd_file_dispose_list_delayed(&dispose);
>>>> }
>>>>=20
>>>> static void
>>>> @@ -660,7 +646,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shri=
nk_control *sc)
>>>> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
>>>> 				   nfsd_file_lru_cb, &dispose);
>>>> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru))=
;
>>>> -	nfsd_file_gc_dispose_list(&dispose);
>>>> +	nfsd_file_dispose_list_delayed(&dispose);
>>>> 	return ret;
>>>> }
>>>>=20
>>>> @@ -671,8 +657,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
>>>> };
>>>>=20
>>>> /*
>>>> - * Find all cache items across all net namespaces that match @inode a=
nd
>>>> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire(=
).
>>>> + * Find all cache items across all net namespaces that match @inode, =
unhash
>>>> + * them, take references and then put them on @dispose if that was su=
ccessful.
>>>> + *
>>>> + * The nfsd_file objects on the list will be unhashed, and each will =
have a
>>>> + * reference taken.
>>>> */
>>>> static unsigned int
>>>> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose=
)
>>>> @@ -690,8 +679,9 @@ __nfsd_file_close_inode(struct inode *inode, struc=
t list_head *dispose)
>>>> 				       nfsd_file_rhash_params);
>>>> 		if (!nf)
>>>> 			break;
>>>> -		nfsd_file_unhash_and_queue(nf, dispose);
>>>> -		count++;
>>>> +
>>>> +		if (nfsd_file_unhash_and_queue(nf, dispose))
>>>> +			count++;
>>>> 	} while (1);
>>>> 	rcu_read_unlock();
>>>> 	return count;
>>>> @@ -703,15 +693,23 @@ __nfsd_file_close_inode(struct inode *inode, str=
uct list_head *dispose)
>>>> *
>>>> * Unhash and put all cache item associated with @inode.
>>>> */
>>>> -static void
>>>> +static unsigned int
>>>> nfsd_file_close_inode(struct inode *inode)
>>>> {
>>>> -	LIST_HEAD(dispose);
>>>> +	struct nfsd_file *nf;
>>>> 	unsigned int count;
>>>> +	LIST_HEAD(dispose);
>>>>=20
>>>> 	count =3D __nfsd_file_close_inode(inode, &dispose);
>>>> 	trace_nfsd_file_close_inode(inode, count);
>>>> -	nfsd_file_dispose_list_delayed(&dispose);
>>>> +	while(!list_empty(&dispose)) {
>>>> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
>>>> +		list_del_init(&nf->nf_lru);
>>>> +		trace_nfsd_file_closing(nf);
>>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>>> +			nfsd_file_free(nf);
>>>> +	}
>>>> +	return count;
>>>> }
>>>>=20
>>>> /**
>>>> @@ -723,19 +721,15 @@ nfsd_file_close_inode(struct inode *inode)
>>>> void
>>>> nfsd_file_close_inode_sync(struct inode *inode)
>>>> {
>>>> -	LIST_HEAD(dispose);
>>>> -	unsigned int count;
>>>> -
>>>> -	count =3D __nfsd_file_close_inode(inode, &dispose);
>>>> -	trace_nfsd_file_close_inode_sync(inode, count);
>>>> -	nfsd_file_dispose_list_sync(&dispose);
>>>> +	if (nfsd_file_close_inode(inode))
>>>> +		flush_delayed_fput();
>>>> }
>>>>=20
>>>> /**
>>>> * nfsd_file_delayed_close - close unused nfsd_files
>>>> * @work: dummy
>>>> *
>>>> - * Walk the LRU list and close any entries that have not been used si=
nce
>>>> + * Walk the LRU list and destroy any entries that have not been used =
since
>>>> * the last scan.
>>>> */
>>>> static void
>>>> @@ -1056,8 +1050,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>>>> 	rcu_read_lock();
>>>> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>>>> 			       nfsd_file_rhash_params);
>>>> -	if (nf)
>>>> -		nf =3D nfsd_file_get(nf);
>>>> +	if (nf) {
>>>> +		if (!nfsd_file_lru_remove(nf))
>>>> +			nf =3D nfsd_file_get(nf);
>>>> +	}
>>>> 	rcu_read_unlock();
>>>> 	if (nf)
>>>> 		goto wait_for_construction;
>>>> @@ -1092,11 +1088,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>>>> 			goto out;
>>>> 		}
>>>> 		open_retry =3D false;
>>>> -		nfsd_file_put_noref(nf);
>>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>>> +			nfsd_file_free(nf);
>>>> 		goto retry;
>>>> 	}
>>>>=20
>>>> -	nfsd_file_lru_remove(nf);
>>>> 	this_cpu_inc(nfsd_file_cache_hits);
>>>>=20
>>>> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), ma=
y_flags));
>>>> @@ -1106,7 +1102,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>>> 			this_cpu_inc(nfsd_file_acquisitions);
>>>> 		*pnf =3D nf;
>>>> 	} else {
>>>> -		nfsd_file_put(nf);
>>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>>> +			nfsd_file_free(nf);
>>>> 		nf =3D NULL;
>>>> 	}
>>>>=20
>>>> @@ -1133,7 +1130,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>>> 	 * then unhash.
>>>> 	 */
>>>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>>>> -		nfsd_file_unhash_and_put(nf);
>>>> +		nfsd_file_unhash(nf);
>>>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>>>> 	smp_mb__after_atomic();
>>>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>> index 940252482fd4..a44ded06af87 100644
>>>> --- a/fs/nfsd/trace.h
>>>> +++ b/fs/nfsd/trace.h
>>>> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
>>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
>>>> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
>>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>>>>=20
>>>> TRACE_EVENT(nfsd_file_alloc,
>>>> --=20
>>>> 2.38.1
>>>>=20
>>>>=20
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever

--
Chuck Lever



