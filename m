Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACE6115DA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJ1PaN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJ1P3p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 11:29:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDD13D2A
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 08:29:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEjXM7030154;
        Fri, 28 Oct 2022 15:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FmHcDUhxhVjcJEs2RsLCvBd+NnIQ1oeZ9S0oF/wkNwg=;
 b=KAgBqrk6kNyNIaprelbiW27/9jyO7J80bNV/jXxRR52Q/v35oSIx58pg2g0djg0zIlfy
 mzUTEjP7pRgFnQ8/1wbTH5nbdo8Bg2RXdMVrvnZFcFWylKTdklBTkA+avQK9T1LsRth8
 ijWx65Nox5c8nUqlkkXyZMJ7wO69vgF+NcrP/ls2ZE29K82oZ5VL3zZZ+k3oAn6k7Waq
 bTtsI/6wwddMfS4vcBzx5a0ZFIfvsS/FHrM3rcw8ItKV4+4WVJM5NOhJO21wo3ZFwfYU
 zQANucSWqMuKnlQ2qlJPv2Hwb2ARPo2AEZc0wNqFbJzGm0r4fRWt6murCi2/h9zRlGvy Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrwce5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:29:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDxIhd012298;
        Fri, 28 Oct 2022 15:29:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags6nt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgpP+yzy6IW39yiW18yXQGop9cBbdYi70djHb3+ezYuqiyuMQyVsrHprGZwtX34IHyHyiIVtaM61Rj6iJimwpNP+xSJ+T4KcWULXRPne69AvsCSZdTjNzVCWFob21d9JWx1zeTBKNqRAV+1nYGD+qm0DzgPpgU3gyJZMN9FL9E49G+FcGWytEKmtuwQDJ2xFB2rs7H1l6dQShUal1p4cLPD3cuXmnr+/jV+kHwFHHorOtyqObKPc5qR0tGmLNwHm6/Cg4ql+yxYDtWPSrVePMygXUqgQPRGEDYBGhUMJTMeWkg4Ef/R9d7jFEC7xrppC3gN3Io4/4UkeCTFIHHQ/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmHcDUhxhVjcJEs2RsLCvBd+NnIQ1oeZ9S0oF/wkNwg=;
 b=jD4xQrAd+YkVkl8FRBa421ZNteLXN9SYCIJyCJKgSOOb4bH1Q+ssG3GAZJZip6VfOx+17D/lm+OWQtNO917BW+++hF/I2kd9POfnS0O2HZahZIkOflPctUpeb2PVv31BTuwciM1U5rQID500HDyxX7wwYS+2oiQH1bCV6+XAD/rRy2zASjM8W+pDpQi5y4Cf565yQUX30nXLildexdIDWo6NWCH6iWnqUyodG9kPEuHaGknIAAQjehU4+MeydObaqRE0IwqSG8SnRvLJR6qXlk2i6ZTEdnlIqrRsyYD9Ub/+WUsy6H9mZ2aoNv/xLhJFcMQauhjGnta4+byxTRSrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmHcDUhxhVjcJEs2RsLCvBd+NnIQ1oeZ9S0oF/wkNwg=;
 b=rH/vxq5M1yen1Tx1PSdrbgDRqqHkmznniVDLc4WIe6nNQWK3+k2kV+GWBrScCgfqlSHK8R48S6iTfdiygsX4fLrI4V/05niBwbktf3Pxq7jQfwMmJnjz4mXr6xOODF1kIiFtrVF7AGG4BKaqgBh7dSSC3l2u4jOIcgj9H7EHP4E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 15:29:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 15:29:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Topic: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Index: AQHY6k5k3iaHcLvdwUOL1QTSt6QmjK4jykqAgAAebwCAAAbTAA==
Date:   Fri, 28 Oct 2022 15:29:35 +0000
Message-ID: <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
 <20221027215213.138304-4-jlayton@kernel.org>
 <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
 <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
In-Reply-To: <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4223:EE_
x-ms-office365-filtering-correlation-id: dd773b00-33d7-4b64-ceae-08dab8f9380b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ET1E8R3eBN/NOMf6YP1QRIjkeXRrr5tEI9m7qqawqS5KnficdPXh12cbi9dw4CbIuu8ZBBBVNamxhFtB8la18l+7IheLD363ITashruW38LyO+Tz8uz1SaIEu/L34QnTrdVw4g+HxfnRT28Z5KeoBG7BgeXdYsDwNkZdYCrb9jkjgQS4+naj31iEWkB6IcEYUNBfCuGKP1XnbZjfKZ3IDGwLRrAw7aavlW6Ag8VCzOLRaRfw/f7lAVtA3Dw6YV7TnFsnQbkdyRlBG1YfzvZtopFIAcbVTlcvp1YwnT4IlLmsfcskoMmOq34L9Kc6wz+8P3pfWi+T/geKYDV2sk/ciXMTiD7EL9cfE+/LtLv/H9eFCFDD1niOrFNck7hqk1l9q2vsnDG8M17Clp3jSrg+ZtH+zJyUS0Tff8NPAvIETtrqvKLrVVw7axUHx6X2CvBJWBtkldG2H1e7Nnn0o4ILLm1Myqz8RIppjFiG5YchlkJYEjrse7dnr1gPGuyZWi7uGBItu1CEBrOHHoCb0MzOD5H1pQLDV/ZwN61+xx32n1o6jPaqaPwIVrwXNtJD01Wq2IL+JxBV8pPBoZOLsjf/gBNrmNtv9BzdqKn9jtxIlhkOMBZemzQBu6yRFsa5tI6MlYBhayvfTTGjPjhgjqQEJaDUMKKHzVPSEx9FW3xtXISsjFnuAlIwxyKSW9MUNdxMigSDYQmtMkKdFOo+TlvtbQzkUcRdx1ll0IGHv5p90fY3zDnMvLDUzXLWmOts0wZPe8w80HtPi4bh/NmOBYNku4oQ+H6Z5x9ShL5XDUe6nIY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(86362001)(36756003)(33656002)(38070700005)(38100700002)(122000001)(53546011)(186003)(2616005)(26005)(6506007)(6512007)(2906002)(5660300002)(4001150100001)(478600001)(83380400001)(66556008)(41300700001)(6486002)(71200400001)(4326008)(66946007)(54906003)(6916009)(76116006)(316002)(8676002)(64756008)(66446008)(66476007)(8936002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RqzJzyfMp6N2W3gbu1cLi2CmprVbb31IlAUhPnrHpU7ywV+raRXPriL4lzBQ?=
 =?us-ascii?Q?/zq1YlbbECIRHdOnFxjB1ivexEgIwpjZ1mfngH8PenmAhYrRTWq29tZ/Qysd?=
 =?us-ascii?Q?f8mgV1WlzC0wZ90RGmN3xMgUXSXeWRRgW59uxkkcjxK97/xBmxP98Y1jy3AM?=
 =?us-ascii?Q?ZWA+ehl4QXWYXWlebbvN8ie/ZMw4kE4IbAIw7Djc8w1F7EySJ/qJ8ZWwA5Jj?=
 =?us-ascii?Q?kFBDTvEuJuX/A9UaRsXl1iapRD38W7PQbd7Qpka93wkbTPFAcMlZ9fx+DmgX?=
 =?us-ascii?Q?DbpH7aRamfFxju29sQMFdy0EGTWRvvOF8eUCLHhCj6ZXSDh3RTbbUhxr9cNP?=
 =?us-ascii?Q?Nmv6AMl26ke3dm3W1SP+3KhOyeZDy/TVypH6/VxMRWvKjNVqRjNqBzq6d3eK?=
 =?us-ascii?Q?8tGShsMDxPceD/+02nvHPxu0ZzDld7RCD3rEBEj3onCPjCsvNEWySRut0fXi?=
 =?us-ascii?Q?aHj3QorGnwrcHv9qb1bWfBly/KZQ7OPGJ2BFzHpseSi8cetbO3GaolOO8WE2?=
 =?us-ascii?Q?walvbp7Ggr7wXBkeyzaRR5klzInHoAcHn3HFRo8BRllM4zgZzQuEjD6c+o8N?=
 =?us-ascii?Q?kqOncDC+5yOv+hWaJOwwYODTAD+keO/zx7/DHDYPOjy4mHV4hWGhjiUPGQj9?=
 =?us-ascii?Q?dzoKsi/Z3z8sh3kn1KO2yQn6AjM/kCy4uK0mMsi3gcs+g8beVMEoEarQrha/?=
 =?us-ascii?Q?VhzGRmKgYaOOeCpNzzd2bEP9P3GVpXKKMDuhin7sDVEV41i/kewVBIQavcKO?=
 =?us-ascii?Q?IYy7RI18sM2LWZSBTTVJgya7VZBOMORZQFa0kc6KCHWQfEbbmVz1GYwCXm49?=
 =?us-ascii?Q?GlPjH1vXoOMqvOKz4yHJG/oaiv23d1e0T1HMCdZE+pOiCLSdpaMByzdzYjso?=
 =?us-ascii?Q?E7D+9P+Bdc5l/ilu0Gh2PvfmXntD5M6B6E62y9lf5H7rOVckKZS6S0lVNZtE?=
 =?us-ascii?Q?hFXReokGJVJ7LJdtnvVC82lnUvbxRQb+mKxWvhxGGGcvY//2/pirZghQLfXg?=
 =?us-ascii?Q?16E0ZxgZYaUaQCj2GmlYTLJOHriKGyfcHVlUGQ5jdDabPR78LE1o3tHwycqt?=
 =?us-ascii?Q?u9xHt9ftl0T4g8MKLzpWzhs5MQTQ1cYYjHyw8uMorA+cOznCFKmBit11jZKT?=
 =?us-ascii?Q?Nr3aXPc+JTesCbpqIjGA/avFYpvfxiwttfy1vech7S2Gbh+RUBgCDPSZ3lRJ?=
 =?us-ascii?Q?+rVvO+06hIEsbsWENmLjC3bTiQNGsL1cXpGocbZk8NMqN2sk6o22SkFHreOh?=
 =?us-ascii?Q?uCAGSEAmWOjDs67iZllmFL/9xMZJrfVxcG74C44TeBEH65XfVxUUoNTTKWg7?=
 =?us-ascii?Q?OBG4+Hqk1IEFN6jZtoUhHaf01z+Wu09ed7qasauMXCtJtVXOU/e9yt0HlQ0W?=
 =?us-ascii?Q?rGiWvwsMSu4TF9aFqOJ6SKbN2Uk5K9Suq+uYL9EnCMSgF9fbAT4NhcLcWFG7?=
 =?us-ascii?Q?y3CffTzSTZ2hFjYCm425ZnjAaoWoA/lfzcLnXKPjoWiWtUPgCJvpxlEy5qW1?=
 =?us-ascii?Q?4GBOyOTI4C2G3eKcilGSJazh1t2FEBMRoMqqMclq70/OCeiWT8ICXTKmu3yF?=
 =?us-ascii?Q?QPSUqLUCOibmt7QPRWUdaEFWs2GPICaEDa+Jl8e6i7ZCJgwoJYxjlIfokEyJ?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10979FADA94974448B547F17CCD5D5AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd773b00-33d7-4b64-ceae-08dab8f9380b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 15:29:35.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/hqTszF6mcF4lC9eO5s5YFgcTeaOtfqQiNu59PtVZnL2PcEQrm9S+4ulBd58il+x8kVW5nWOltp8Pa4FLboAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280096
X-Proofpoint-ORIG-GUID: 6nSGRydjMvkA_AoUwF5J4MGDv8lTrpqt
X-Proofpoint-GUID: 6nSGRydjMvkA_AoUwF5J4MGDv8lTrpqt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 11:05 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 13:16 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 27, 2022, at 5:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
>>> so that we can be ready to close it out when the time comes.
>>=20
>> For a large file, a background flush still has to walk the file's
>> pages to see if they are dirty, and that consumes time, CPU, and
>> memory bandwidth. We're talking hundreds of microseconds for a
>> large file.
>>=20
>> Then the final flush does all that again.
>>=20
>> Basically, two (or more!) passes through the file for exactly the
>> same amount of work. Is there any measured improvement in latency
>> or throughput?
>>=20
>> And then... for a GC file, no-one is waiting on data persistence
>> during nfsd_file_put() so I'm not sure what is gained by taking
>> control of the flushing process away from the underlying filesystem.
>>=20
>>=20
>> Remind me why the filecache is flushing? Shouldn't NFSD rely on
>> COMMIT operations for that? (It's not obvious reading the code,
>> maybe there should be a documenting comment somewhere that
>> explains this arrangement).
>>=20
>=20
>=20
> Fair point. I was trying to replicate the behaviors introduced in these
> patches:
>=20
> b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()
> 6b8a94332ee4 nfsd: Fix a write performance regression
>=20
> AFAICT, the fsync is there to catch writeback errors so that we can
> reset the write verifiers (AFAICT). The rationale for that is described
> here:
>=20
> 055b24a8f230 nfsd: Don't garbage collect files that might contain write e=
rrors

Yes, I've been confused about this since then :-)

So, the patch description says:

    If a file may contain unstable writes that can error out, then we want
    to avoid garbage collecting the struct nfsd_file that may be
    tracking those errors.

That doesn't explain why that's a problem, it just says what we plan to
do about it.


> The problem with not calling vfs_fsync is that we might miss writeback
> errors. The nfsd_file could get reaped before a v3 COMMIT ever comes in.
> nfsd would eventually reopen the file but it could miss seeing the error
> if it got opened locally in the interim.

That helps. So we're surfacing writeback errors for local writers?

I guess I would like this flushing to interfere as little as possible
with the server's happy zone, since it's not something clients need to
wait for, and an error is exceptionally rare.

But also, we can't let writeback errors hold onto a bunch of memory
indefinitely. How much nfsd_file and page cache memory might be be
pinned by a writeback error, and for how long?


> I'm not sure we need to worry about that so much for v4 though. Maybe we
> should just do this for GC files?

I'm not caffeinated yet. Why is it not a problem for v4? Is it because
an open or delegation stateid will prevent the nfsd_file from going
away?

Sorry for the noise. It's all a little subtle.


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
>>> 1 file changed, 31 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index d2bbded805d4..491d3d9a1870 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
>>> }
>>>=20
>>> static void
>>> -nfsd_file_flush(struct nfsd_file *nf)
>>> +nfsd_file_fsync(struct nfsd_file *nf)
>>> {
>>> 	struct file *file =3D nf->nf_file;
>>>=20
>>> @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
>>> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>> }
>>>=20
>>> +static void
>>> +nfsd_file_flush(struct nfsd_file *nf)
>>> +{
>>> +	struct file *file =3D nf->nf_file;
>>> +	unsigned long nrpages;
>>> +
>>> +	if (!file || !(file->f_mode & FMODE_WRITE))
>>> +		return;
>>> +
>>> +	nrpages =3D file->f_mapping->nrpages;
>>> +	if (nrpages) {
>>> +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
>>> +		filemap_flush(file->f_mapping);
>>> +	}
>>> +}
>>> +
>>> static void
>>> nfsd_file_free(struct nfsd_file *nf)
>>> {
>>> @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
>>> 	this_cpu_inc(nfsd_file_releases);
>>> 	this_cpu_add(nfsd_file_total_age, age);
>>>=20
>>> -	nfsd_file_flush(nf);
>>> +	nfsd_file_fsync(nf);
>>>=20
>>> 	if (nf->nf_mark)
>>> 		nfsd_file_mark_put(nf->nf_mark);
>>> @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
>>>=20
>>> 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>>> 		/*
>>> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
>>> -		 * it to the LRU. If the add to the LRU fails, just put it as
>>> -		 * usual.
>>> +		 * If this is the last reference (nf_ref =3D=3D 1), then try
>>> +		 * to transfer it to the LRU.
>>> +		 */
>>> +		if (refcount_dec_not_one(&nf->nf_ref))
>>> +			return;
>>> +
>>> +		/*
>>> +		 * If the add to the list succeeds, try to kick off SYNC_NONE
>>> +		 * writeback. If the add fails, then just fall through to
>>> +		 * decrement as usual.
>>=20
>> These comments simply repeat what the code does, so they seem
>> redundant to me. Could they instead explain why?
>>=20
>>=20
>>> 		 */
>>> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
>>> +		if (nfsd_file_lru_add(nf)) {
>>> +			nfsd_file_flush(nf);
>>> 			return;
>>> +		}
>>> 	}
>>> 	__nfsd_file_put(nf);
>>> }
>>> --=20
>>> 2.37.3
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



