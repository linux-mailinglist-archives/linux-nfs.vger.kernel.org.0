Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92131612BBE
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3RMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3RMf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 13:12:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462EF26E
        for <linux-nfs@vger.kernel.org>; Sun, 30 Oct 2022 10:12:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29U8GBf3017765;
        Sun, 30 Oct 2022 17:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+ns0yBP6vKmMCc4e5pOHa6qR/PypEdYNaMY3IAdWjhU=;
 b=N6Zty/8+VG/wgyXzxmAjpwWTZlbzT8cnt9Y+pQezHt8coHQ/LIXo3nHKpi/GD/CxfpeR
 UG0NwbbBoNBcSAzmw7Ke7JsNsOsb8BaAJ1xG7xEeNkF9pnZnzt5nuOQyWCDDhfjgoF+f
 nIYuTuyC+mXSqC6Vv488gR4kL0/P2cn1Ms9G9BMVrfZiD1tKJeDAEqj3PFAwfDUJivvH
 Z5jhKWx7hxfQbdGTIQa4YlXrDgA3ZGLpHXEX0ic4zL+ucaYoH6X5rCYRtUbAPvgEaWjQ
 h0riyd0kFNKRK2r5huAnvt1sfxGiT6eMusKJmSGDio90bdbDjQKSN2al1peP5bnMWZ33 rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2a9sg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 17:12:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29UCOea0019682;
        Sun, 30 Oct 2022 17:12:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm8h46m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 17:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AflKPolANLcPPFRwO7JzIJ9qcQeouKElpomv0V1lD0Fb5FzHjIHh2XHAclfjgt9O3DbjRmWZZ4bDYRbI3bF16nHkQiSDNS9KM61lKrXBLWbtpJbo1PYeTxh009FuWwvhd4Mgt5AA0Pf08jz0wLYSnfV1cD/w7O+3bMk2z09zhBwsdqw6CA9ZboMqk8U5ld1TcUWMw+pkAx6ikYwXCt/jQiqtDAy+hMXc8SKgB86hJqM5vPSEMexqX1LwlEPIZj5Ni3Ac6HQaFbcJ5eX22lQbR2WZvB09wDph0z3MqFnIG9H3X1UI2MQJIHwwf5NjCo+udqfyNz36IGO/gujK8kewKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ns0yBP6vKmMCc4e5pOHa6qR/PypEdYNaMY3IAdWjhU=;
 b=Tl14q6vxVAQ28Aa+xq25yaoukbETiyaa5io4BrFesydfl4vv98T59RXoMy0BzH4S00W120e+RCOmLVN7stt0JY9VzsIWiswlCgfcOjz6TBBNH08Gx8ka5ITNylb7sAKXodImAHlrzzxkKMoXW990VuijeeVRSOzPXWeFIKM7miTsWtK3/vRd2njCSsPB4b2n6+EQovuvJoHxMpD4/F9Gp6eUpgQgMQTHncN6JDtcueydC8PR+Y+Te7tJc3JXAKq0FmFaqZTpeYVLKhaVm39DITZUD0mhWt/dchX7YnGn1HqOiMGD0x80ZMFe744zf60pruYnsb6syWbLEgkT0+AIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ns0yBP6vKmMCc4e5pOHa6qR/PypEdYNaMY3IAdWjhU=;
 b=O2x69Etm6QnA/3aim7CzJQz04D5OfBn8P5A+9U2md6vsrTKna39AExlaA2Pv9yUbEo5Ep3tEeC3YN/7YNCZHm5WQXLHepREZLLz/1bx93yBCg+gFA3U7LEV4QDQVKw/QuaIVGcBw1xfQwc8J2veF5uaQZf08YEzWu+1CB48rXcE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 17:12:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.016; Sun, 30 Oct 2022
 17:12:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Topic: [PATCH v3 1/2] NFSD: add support for sending CB_RECALL_ANY
Thread-Index: AQHY6nNLIPitKTs0XEalLwD47leXtq4j2ZQAgANHfwCAAA+UAA==
Date:   Sun, 30 Oct 2022 17:12:25 +0000
Message-ID: <91927B86-76D7-4C5C-B8C5-8AF30BF52547@oracle.com>
References: <1666923369-21235-1-git-send-email-dai.ngo@oracle.com>
 <1666923369-21235-2-git-send-email-dai.ngo@oracle.com>
 <D080D405-5567-4581-A347-417E859A568D@oracle.com>
 <a29c1888-d260-1108-5365-8385192b4367@oracle.com>
In-Reply-To: <a29c1888-d260-1108-5365-8385192b4367@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4524:EE_
x-ms-office365-filtering-correlation-id: f57635e0-3561-412c-af50-08daba99eac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ySUiTLDVQ8zoeTRQGW5DbT8KA1ipC9R3IMVptesySX240z/2ltxobgSEXoLcxnyQjJEJaOd9+Gf9Sd0ALrCmmtayYf1bs5mmnbxnFAkkjBW2TbBk4Nr4pCWx0lwVYOsxAVUKb9vwcPp6z1YhUx2XwEeApl+ZFVjtKEgr7uEksf0QRAgjCpsKU59IKotW+6D/2aaUloQPocxYosljPEzbc1EEwdV27ShkB+bMEd5+8lVMnwfjL+Q7OFX9PZjY3crQ2boVM7ezue/QPgM30eb4CyVBWoudBwnWob9DNqXVySB2SNK02DRDzbkZQAQYGCo9QUySM6ottTt9fFf6CHRNRuWDLjYYXtJ9i1N5+q8itG0pmL2meZokEfb4hiymPKYCIGrb4GY9w6KVBMxf/gFV46ZBCP+ptEyTU2Oej9P7em+hDVdHVQt0BiuQ4twyrJ1oZvK+myjHflQ14b/wVeNs5MhnBZFqv22jI4rVSVaXkGVtTKuvvMreBLhB91AERDcPmpnI9OLyZbuqAhOcXbZWazaVz5v4jzEHlYt3R54+cxhnEP8oN0ZbpnewDAqg0IfmEYAmA9Krd9JddTXY1zjqdBEpTVRDm91mFaLfWAryXkxznhqKetVJ0dx+pAHT6LSNHh3qe0PLzGSEiod7y9JFrYZ9FVm1skKRAuTBvi2ySZ4PTcDyiRqH17p9hL1vBEMZTpEeDp9X3MUCHc9VDAVgnipqhyovoPZBNH8I/6Gke1FqQVYlj9k/3eU7RuRVFejhvf8Ajhp8CwNuVdM+Cqrqg0hpPGYOAjnyXKmpHneHIxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(6512007)(2906002)(83380400001)(26005)(5660300002)(38070700005)(2616005)(186003)(8936002)(6862004)(30864003)(33656002)(86362001)(36756003)(38100700002)(122000001)(478600001)(71200400001)(316002)(6486002)(8676002)(6636002)(37006003)(54906003)(66446008)(6506007)(66946007)(4326008)(66556008)(64756008)(66476007)(53546011)(41300700001)(66899015)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dur64Pj9P+7pnKQx0KyuI/gaW2hromjGIxfmFTdTjZHnexFtGvbf463zBcgP?=
 =?us-ascii?Q?b4jLnnzVNYDg6p05WdvQtz4ugsXIJRSRzUXgVHT3hw6hOdDcQchByKqWXK+R?=
 =?us-ascii?Q?BUb768mFf4sUnkwSBKA5lmzIw1ggSAWQgiL8WL4+0NELxxZaLBZ2JZYLJApM?=
 =?us-ascii?Q?Aaac8O97UMmCOOZ//G2R5ElbmImSTAHTgLzgLorWuirR2VE5xqcHYq6+E1pp?=
 =?us-ascii?Q?ykDIsLjIIO3ZxYQQAHKhjTdvXHctvZcrKZdJo9ZF4Q+l846toLZwF46f32ug?=
 =?us-ascii?Q?75BwSRnXtsNoSz1N2/E4r+kIRkpG8b0X0xHA8N0GNk5WiI8bjKwyecfOckCa?=
 =?us-ascii?Q?CX//gm7EdAOpTIJp0Sso4qhuCh0Fwfk49pXk9tmTygNZVPYzn7RGpP9UoWZq?=
 =?us-ascii?Q?4gruJAJ39QE02fOlkbqTWuk4QglgGOT37B8idhepUI5X+9yPrb5n6N4sho6K?=
 =?us-ascii?Q?uh7vgcV+1SAsTa7ddHBswM5HPj70Sb5OEpKM2rYeNTIy6tPIQxm3noUkgXoA?=
 =?us-ascii?Q?BkEQ9CnJzKkUHTi5QMgpDFSajTf892kUEme0QQKPxmgsrimHKqwGD8lHT3EI?=
 =?us-ascii?Q?hvXwTY3YMJsiLaYbmb66Pf247VB9HCOpCJovMGsXZNX1ZoJOOfmLUS9olt9b?=
 =?us-ascii?Q?+t8kwb5K2wQf8iX6kC50+P1vUaas2TRfpzH6Sum01/qgUZaUR9aBzbqWQYGT?=
 =?us-ascii?Q?ECzAX4mKhk96sM3sQLZVs3mOFkncq5LvgFbDTt1Ppmgt9+yRmPulIQfU0OfB?=
 =?us-ascii?Q?hJ5xnssCfiOrTS3lhdSuuCpF0Crt2Y9OkK72crc7W9nj2Q454siYz/EOReOQ?=
 =?us-ascii?Q?dR5bItrJyDGaZAlEzC8Q9YutHFxZicbG8NNdCokLLXdQiasrdPF+77fgk5gY?=
 =?us-ascii?Q?RMips43/o+vJr2X+s6oQYZ6bYMId1co5v6yDIt+mnN8mn1ocrqp+fsEwNg40?=
 =?us-ascii?Q?DZaYMrSAyTk3csPIQOcHTT9LwIuRnEE5w8P0U8ZTEhRkfVspVxYHRH6qFvNm?=
 =?us-ascii?Q?ELoIqNcExy4My+k2KhxfK8Gdrj13OBJN9QZ3bawmlxqNwSG0IMOYhuscoint?=
 =?us-ascii?Q?d9R8+No2N2uuefeK0yOdGqIV99fm9inl2TIB2hbtKEFiPErKwSMVwA1NZO7S?=
 =?us-ascii?Q?GNmPhyJx52CHiH+/B/1WRg3DU6lGee7PO1X99b3bnsrDc4M3n3A5hfoy2d2M?=
 =?us-ascii?Q?ZvBDvXwHYT2MujMeE3P3VU/S7QGHWmJ6HF/mysLxFVaZmvXM0TC/OwtkKd/2?=
 =?us-ascii?Q?+H9dyuJu5IsaUtjdKWUeCU8yAJDjk0uwsgRMPVOFNlikYFRrfPWK6YDHb8Mk?=
 =?us-ascii?Q?nD6WrsroyzNAD07Xy+7H7yH4s7C6a1CWObQtTJ1tbgd6iMaOuIeaMDJJKWot?=
 =?us-ascii?Q?AjCE1Sk1fugjDlthDxWkOlDk5SzG3nT56V1x4azR5HCN+wvugwnIWXBiaOHc?=
 =?us-ascii?Q?xXkcpRrcSvJDgHdsYL/SKqfo1ITFHAJeAIAvsUxnML1vf5Aa6rqsbdsUvGfl?=
 =?us-ascii?Q?YNuXaNUWMbdV4QRRObwAHzfyTLdRWPzediLv2a7Lkp16vpL1fhXio1WsPTyJ?=
 =?us-ascii?Q?OeZTugKi+x9HHw+8/GPZZMqzDy2hH0z67QfeMZtFv2t5a2m9pwNGBIG0kHWM?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02BD50F82D5DBB4A8E67C30FD75CD80E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57635e0-3561-412c-af50-08daba99eac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 17:12:25.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMno+KQWbQ3kdRTQI/9kAdrOv8H1H29gfAJqv/tLxGgk8BnNZS+oyR7/Oz+2bZNeFke3X2djoVnHh9bk8XEMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210300114
X-Proofpoint-ORIG-GUID: q81foS69dzzwoPTnadL41Id8vWr33D3C
X-Proofpoint-GUID: q81foS69dzzwoPTnadL41Id8vWr33D3C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 30, 2022, at 12:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 10/28/22 7:11 AM, Chuck Lever III wrote:
>>=20
>>> On Oct 27, 2022, at 10:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> There is only one nfsd4_callback, cl_recall_any, added for each
>>> nfs4_client.
>> Is only one needed at a time, or might NFSD need to send more
>> than one concurrently? So far it looks like the only reason to
>> limit it to one at a time is the way the cb_recall_any arguments
>> are passed to the XDR layer.
>=20
> We only need to send one CB_RECALL_ANY for each client that hold
> delegations so just one nfsd4_callback needed for this purpose.
> Do you see a need to support multiple nfsd4_callback's per client
> for cl_recall_any?

CB_RECALL_ANY has a bitmap argument so that it can be used for
recalling many different types of state. I don't pretend to
understand all of it, but it seems like eventually NFSD might
want to send more than one of these at a time, and not just in
low memory scenarios. I suggest a way below of doing this
without adding complexity.


>>> Access to it must be serialized. For now it's done
>>> by the cl_recall_any_busy flag since it's used only by the
>>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>>> then a spinlock must be used.
>> The usual arrangement is to add the XDR infrastructure for a new
>> operation in one patch, and then add consumers in subsequent
>> patches. Can you move the hunks that change fs/nfsd/nfs4state.c
>> to 2/2 and update the above description accordingly?
>=20
> fix in v4.
>=20
>>=20
>> In a separate patch you should add a trace_nfsd_cb_recall_any and
>> a trace_nfsd_cb_recall_any_done tracepoint. There are already nice
>> examples in fs/nfsd/trace.h for the other callback operations.
>=20
> fix in v4.
>=20
>>=20
>>=20
>> A little more below.
>>=20
>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4callback.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>> fs/nfsd/nfs4state.c    | 32 +++++++++++++++++++++++++
>>> fs/nfsd/state.h        |  8 +++++++
>>> fs/nfsd/xdr4cb.h       |  6 +++++
>>> 4 files changed, 110 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index f0e69edf5f0f..03587e1397f4 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_strea=
m *xdr,
>>> }
>>>=20
>>> /*
>>> + * CB_RECALLANY4args
>>> + *
>>> + *	struct CB_RECALLANY4args {
>>> + *		uint32_t	craa_objects_to_keep;
>>> + *		bitmap4		craa_type_mask;
>>> + *	};
>>> + */
>>> +static void
>>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>>> +{
>>> +	__be32 *p;
>>> +
>>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>>> +	p =3D xdr_reserve_space(xdr, 4);
>>> +	*p++ =3D xdr_zero;	/* craa_objects_to_keep */
>> Let's use xdr_stream_encode_u32() here.
>=20
> Yes, we can use xdr_stream_encode_u32() here. However xdr_stream_encode_u=
32
> can return error and currently all the xdr encoding functions,
> nfs4_xdr_enc_xxxx, are defined to return void so rpcauth_wrap_req_encode
> just ignores encode errors always return 0. Note that gss_wrap_req_integ
> and gss_wrap_req_priv actually return encoding errors.

The convention it seems is to ignore errors in this code and assume
that the upper layer has set up the send buffer properly. Anything
else would be a local software bug, so it is probably a safe
assumption.


>>  Would it be reasonable
>> for the upper layer to provide this value, or will NFSD always
>> want it to be zero?
>=20
> Ideally the XDR encode routine should not make any decision regarding
> how many objects the client can keep, it's up to the consumer of the
> CB_RECALL_ANY to decide. However in this case, NFSD always want to set
> this to 0

"in this case" I assume means in the low-memory scenario. I don't
know enough to say if other scenarios might want to choose a
different value.


> so instead of passing this in as another argument to the
> encoder, I just did the short cut here. Do you want to pass this in
> as an argument?

I don't think it would be difficult to parametrize this, so give it
a shot. Suggestion way below.


>>> +	p =3D xdr_reserve_space(xdr, 8);
>> Let's use xdr_stream_encode_uint32_array() here. encode_cb_recallany4arg=
s's
>> caller should pass a u32 * and a length, not just a simple u32.
>=20
> fix in v4.
>=20
>>=20
>>=20
>>> +	*p++ =3D cpu_to_be32(1);
>>> +	*p++ =3D cpu_to_be32(bmval);
>>> +	hdr->nops++;
>>> +}
>>> +
>>> +/*
>>>  * CB_SEQUENCE4args
>>>  *
>>>  *	struct CB_SEQUENCE4args {
>>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst=
 *req, struct xdr_stream *xdr,
>>> 	encode_cb_nops(&hdr);
>>> }
>>>=20
>>> +/*
>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>> + */
>>> +static void
>>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>>> +		struct xdr_stream *xdr, const void *data)
>>> +{
>>> +	const struct nfsd4_callback *cb =3D data;
>>> +	struct nfs4_cb_compound_hdr hdr =3D {
>>> +		.ident =3D cb->cb_clp->cl_cb_ident,
>>> +		.minorversion =3D cb->cb_clp->cl_minorversion,
>>> +	};
>>> +
>>> +	encode_cb_compound4args(xdr, &hdr);
>>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>>> +	encode_cb_nops(&hdr);
>>> +}
>>>=20
>>> /*
>>>  * NFSv4.0 and NFSv4.1 XDR decode functions
>>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst =
*rqstp,
>>> 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>>> }
>>>=20
>>> +/*
>>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>>> + */
>>> +static int
>>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>>> +				  struct xdr_stream *xdr,
>>> +				  void *data)
>>> +{
>>> +	struct nfsd4_callback *cb =3D data;
>>> +	struct nfs4_cb_compound_hdr hdr;
>>> +	int status;
>>> +
>>> +	status =3D decode_cb_compound4res(xdr, &hdr);
>>> +	if (unlikely(status))
>>> +		return status;
>>> +	status =3D decode_cb_sequence4res(xdr, cb);
>>> +	if (unlikely(status || cb->cb_seq_status))
>>> +		return status;
>>> +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status=
);
>>> +	return status;
>>> +}
>>> +
>>> #ifdef CONFIG_NFSD_PNFS
>>> /*
>>>  * CB_LAYOUTRECALL4args
>>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures=
[] =3D {
>>> #endif
>>> 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>>> 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>>> };
>>>=20
>>> static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 4e718500a00c..68d049973ce3 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -2854,6 +2854,36 @@ static const struct tree_descr client_files[] =
=3D {
>>> 	[3] =3D {""},
>>> };
>>>=20
>>> +static int
>>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>>> +			struct rpc_task *task)
>>> +{
>>> +	switch (task->tk_status) {
>>> +	case -NFS4ERR_DELAY:
>>> +		rpc_delay(task, 2 * HZ);
>>> +		return 0;
>>> +	default:
>>> +		return 1;
>>> +	}
>>> +}
>>> +
>>> +static void
>>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>> +{
>>> +	struct nfs4_client *clp =3D cb->cb_clp;
>>> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>>> +
>>> +	spin_lock(&nn->client_lock);
>>> +	clp->cl_recall_any_busy =3D false;
>>> +	put_client_renew_locked(clp);
>>> +	spin_unlock(&nn->client_lock);
>>> +}
>>> +
>>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
>>> +	.done		=3D nfsd4_cb_recall_any_done,
>>> +	.release	=3D nfsd4_cb_recall_any_release,
>>> +};
>>> +
>>> static struct nfs4_client *create_client(struct xdr_netobj name,
>>> 		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>> {
>>> @@ -2891,6 +2921,8 @@ static struct nfs4_client *create_client(struct x=
dr_netobj name,
>>> 		free_client(clp);
>>> 		return NULL;
>>> 	}
>>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>>> 	return clp;
>>> }
>>>=20
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index e2daef3cc003..49ca06169642 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>>=20
>>> 	unsigned int		cl_state;
>>> 	atomic_t		cl_delegs_in_recall;
>>> +
>>> +	bool			cl_recall_any_busy;
>> Rather than adding a boolean field, you could add a bit to
>> cl_flags.
>=20
> fix in v4.
>=20
>>=20
>> I'm not convinced you need to add the argument fields here...
>> I think kmalloc'ing the arguments and then freeing them in
>> nfsd4_cb_recall_any_release() would be sufficient.
>=20
> Since cb_recall_any is sent when we're running low on system memory,
> I'm trying not to use kmalloc'ing to avoid potential deadlock or adding
> more stress to the system.

Fair. Well, again, there are potentially other use cases that
aren't concerned about memory pressure.

Construct something like this (in fs/nfsd/xdr4.h):

struct nfsd4_cb_recall_any {
	struct nfsd4_callback	ra_cb;
	u32			ra_keep;
	u32			ra_bmval[1];
};

Then either add it to another long-term structure like nfs4_client
or the upper layer can kmalloc it on demand. That way the XDR code
supports both ways and does not have to care which the upper layer
wants to use.


> Thanks!
> -Dai
>=20
>>=20
>>=20
>>> +	uint32_t		cl_recall_any_bm;
>>> +	struct nfsd4_callback	cl_recall_any;
>>> };
>>>=20
>>> /* struct nfs4_client_reset
>>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>>> 	NFSPROC4_CLNT_CB_OFFLOAD,
>>> 	NFSPROC4_CLNT_CB_SEQUENCE,
>>> 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>>> };
>>>=20
>>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>>> +
>>> /* Returns true iff a is later than b: */
>>> static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid=
_t *b)
>>> {
>>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>>> index 547cf07cf4e0..0d39af1b00a0 100644
>>> --- a/fs/nfsd/xdr4cb.h
>>> +++ b/fs/nfsd/xdr4cb.h
>>> @@ -48,3 +48,9 @@
>>> #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>>> 					cb_sequence_dec_sz +            \
>>> 					op_dec_sz)
>>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>>> +					cb_sequence_enc_sz +            \
>>> +					1 + 1 + 1)
>>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>>> +					cb_sequence_dec_sz +            \
>>> +					op_dec_sz)
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



