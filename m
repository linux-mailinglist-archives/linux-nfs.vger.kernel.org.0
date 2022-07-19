Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697CB57A457
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiGSQwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGSQwE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 12:52:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4942850733
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 09:52:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JF4Ki2030732;
        Tue, 19 Jul 2022 16:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MsrVxfCIDoXoCFllajg95rkssIx9yH1gUQkbCciNCLA=;
 b=e8+W6Va5PRx2B9C8Lcn9sAzDh3nzcLHFWXd2IiCsUnsWqqcrU5ZVoVA9CHEEsp5GKj8R
 Z659P1+jy/vhfQjiBuiSPFvIxoV9ZWOvdtAaFtjdkyUF+zhWFofowpQ2K9ZeHqj43kh4
 bbgnUpT4AdgmR6sy5TvzgBwL2BY/u3a+TsvdvbQm31lvcz8RzsaRWXfeqlOf2rBo4NxI
 Ky2/y5El6ZII9NLKsGtxngKyyodgQJZawSXIwMaFwJ0a/MHZhY6Oilcp6SexSFjBGD9N
 6Eve2lPYABWJ5hKF1cZfnUVhvYUesjM54NWkQkdBrdullb0sZVTzTiWjJN56QQDOU8A5 AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 16:51:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JG1vDo022261;
        Tue, 19 Jul 2022 16:51:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hs3988-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 16:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrNFHohRjkxUTDciDIjm0oDA0UEIGUi+VVMIyhzPop7poGTZnr1lZus0qA7X6UJcfDGW1UX4zcFKsNFXVv9xCPuo+fniIbIuv3lUJqonUGGVYTJ6eHOym2JpCwOPyNtLNoorj56xaIowBuyqht33tSYDFh/878MhaLphF4Vl+5ZmGj5E1+hyYuwI4Qi/sIuXwPnrzVlQ8Bk8AQwSt4uTnXvlD5e0l4vApDbhNZ2HuCI3Vobi/ILzO2A4E1ar9X82LyGpP9jZBC0fhvUQkhIuziurbelm5eN5rJMIDblH0mxbe5XTwszGpSk+bfS8HVaA3wwCynR9qRMYmEjEtlc3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsrVxfCIDoXoCFllajg95rkssIx9yH1gUQkbCciNCLA=;
 b=khVxGC+VYfK19jfM7EiVokTSTEK5tX7xPA2GOdR8wknPZ9XOJNGYWfTmwWOlfU4Rgl7+9jrb3RffUUUO9Zz2u201rehL98bPbPYj2hAJ8weP+UmB0f+UW/cLFXCUy9EMr1DgxXOCfJ56xzy2121XAp1smkjFDXxGCmGkfhnRPrIOSEb1XdqDcCiszZvADpms5gov11xRXw7Qr4yvDnw5/ka3mi5V71G+Qs4PcG5kQoBmuasxa89sXYMNK4X/o7FdW9IhefR2n9qGo00vOf96mcFPYInI82atsA7jT/rNkhmf4Ge1KESU88McXNIrU0zcoRK4fvK8R/JNmKTq8KS5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsrVxfCIDoXoCFllajg95rkssIx9yH1gUQkbCciNCLA=;
 b=EU0RqQ0Ik/lXMc5X6YJR82k2w0xLueUTdj1j4iRrRRXSlkqF00TYHqzBq8Uc7KD1NoLCcPuOWEgLAbGFMitCHx6aTqhjOqwC1VjSmt16GIhsXyO8uit4pAzzAdxf3lQb47MasSt9WOzQU+dvlvN6soaT8rBUMcQdLcaiqFmUVe0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1348.namprd10.prod.outlook.com (2603:10b6:404:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 16:51:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 16:51:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix xdr_encode_bool()
Thread-Topic: [PATCH] SUNRPC: Fix xdr_encode_bool()
Thread-Index: AQHYm3idjb1txcveQUC4hm5Y8155S62F12MAgAARYIA=
Date:   Tue, 19 Jul 2022 16:51:56 +0000
Message-ID: <763FBB8E-0023-42FC-86CE-EDBCA75F7E04@oracle.com>
References: <165823671509.3047.16569036635528856192.stgit@manet.1015granger.net>
 <39417eca1dd4a810270cb35d0978b6636aeb0654.camel@kernel.org>
In-Reply-To: <39417eca1dd4a810270cb35d0978b6636aeb0654.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb916d6c-ddd0-42c7-cf94-08da69a6fd55
x-ms-traffictypediagnostic: BN6PR10MB1348:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vSbP62IrvQqIWwqKtuFaJbEz3zVWVyGuAPXzDLjyMmrEjHMwIVqiODi0i7DO1Zgc0TYVXPkpaXO02FRkSiWA7QzVkzsKXebVg04WoDfK5Dp1RKduZkLLlr6MasRl+yYI2t0f7iXXk/sdCNc1sVQLKVMnYoTD7UH0yYr5WkgTxTYBSAITIjK1uXsHEDjyktUSlpPyTBV9xpNGtU79xju84C6WqKTSpCnP4xzcxniVNwzlNyvLpGaq+Dh+DjhVRdz2ATPGFjlydyiR4TqqPS1Jxr89xg6Ve+F8BxKuNzOzobrmxhgayt1YFv5kM7KwvqqLrqdQE1o6QbJ8aPn9O+TY255ihgh0Y+Chw7/gPuJoiz9MMy/NjzBWbXwscrvv0edCQPck1OgrTM2fe+l4iNVnw5UZWmt+ktybycUskuflmw8QDaKXOQ+3dRDOKvQ8gz69LAVxMI6Z3esUEVVPgcE1L7WrhF1qSTDHwN7fX2UcbydU+7OmE+nn1VqAYuwnST4sGny1A2MpHrG3OeNam+yW4+RYroeCZcX1K85AgY9iVsh4JNMfafwXqvVVOvjd2FRsaJQ8KXE+FPC5sm/PhgKHBcYz9CwvmMOVKBnmQM8cNaO73ABU7D7CkLCBpUJW0s9DdY+16Y4bqv3vIWM3IhHCEdSA5KSz3u5VJdymzQGqpP4iIJwn3BEI20S2AtihEaScPJ43Pzxlfr8UWGNzpokp6C5/13b0yO660T6kPVq0EtpHSO3Z8i24VD1/ZgaCX/1FysyBwFFu1X28z4o0kMNNsmyDMSjEaT8llPOA5gaSCvbt8xOVaUMLe+5N7U3ZUPTdfYZz9mV3WyslF16JL/UiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(4326008)(122000001)(8676002)(76116006)(38100700002)(33656002)(83380400001)(186003)(5660300002)(66946007)(8936002)(64756008)(2616005)(36756003)(66556008)(66476007)(2906002)(91956017)(66446008)(6916009)(478600001)(26005)(53546011)(6512007)(41300700001)(86362001)(6506007)(316002)(38070700005)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hBCB8/v6mc31b9HTcozK/D5hOIo0emCmQPnHqKkkrRiF3SQ6WkjSLYlrhtQZ?=
 =?us-ascii?Q?RvzO+EK9kZMgg2zqNrBqga2udvpd8cQD7zdacHsA7o8sMWfNUuSVTnREdNxc?=
 =?us-ascii?Q?GSRGGmBkYIGCg7KS3GVlAu+BwVu/xSQ2WR9pYOIVjYm1ARkhWQDFI+xKbAtD?=
 =?us-ascii?Q?OvuxcHDKD7D8O7QbQtga0b3k9DqVjseamZJoIesEODeprhyqJmaiqfFA9pTB?=
 =?us-ascii?Q?JIS00+X8vEX4KemNeWMj81twA4fanP5qOkkKL3wfakVIc86gbgcLi0jNW6IG?=
 =?us-ascii?Q?E2tgQteaY3pdkvuL+JYPjtIQNzE9wbEYKfFPu7at2qphdPm53O4IHS4dUElC?=
 =?us-ascii?Q?OS/466iYDa1UmliE0Gd6sArDt6gMy3jrFwCTYIqheSpWlT0dC0pNy0GYyAFr?=
 =?us-ascii?Q?oWjk5VYIcBTIm4rnzkGGvp0yyf2Yp0YPi0NAB5rvRsPf3yW2Bxo6ZoXsdC5f?=
 =?us-ascii?Q?gpreOiKNtGXJcQNMrt7TEZI050RlTWpY6M9ACNJ2VdbUWYNz7qrXEVssLnYc?=
 =?us-ascii?Q?kYZCHsZTey4p4WN9m3gSl1v505O5V2VNcV60aXGdtS67qPc8x5MASCEPlfxx?=
 =?us-ascii?Q?HIC7AbdI0w8z2jZI5DT35+kOWgGPAas2Shgz/qriUl2m/TjQPoyigWEbk8rf?=
 =?us-ascii?Q?Xh3pWTiuCial0/cF9aObhbo6N5wWLCiHye8j3cSM45DLIDdv+H7+bFElxSkA?=
 =?us-ascii?Q?j0gfbthhsLgIsJ6Rrtiz2bFKnQM+la007GFR47xn1bnt6rzUlevMg58oLjZQ?=
 =?us-ascii?Q?NxP+kR8w1mlgehN2nvWIsdneHjc+H6xhP3bkwO9QHHZXCuVPOKVlL5eC13B2?=
 =?us-ascii?Q?wASVOARh5psZX8NiPXyMkxqxK09iaYuyAF+iX8rWheau4nov47g6DXIo6ar/?=
 =?us-ascii?Q?yEvyBDsgGz0ZfwuWCQBovY1d8cak9lod2T0hXUDpwFFOkM4I2W5o9w4Bokl+?=
 =?us-ascii?Q?xQesVus7nfHmG4UzwCacOR8Yh3Y8uwvfm78dzWighlnbjw67XTzHkWQkAokl?=
 =?us-ascii?Q?36Kg800bcWhAyKsKy9LNGY0stmCUZeiLhCuQWPvht0BRDjcJNoIHhdGOajOd?=
 =?us-ascii?Q?Tpit+QA24yxlKHLTKLpDbMBJ15gjB1SrFkPH7AeDmf09qpk++c8WkiXL801T?=
 =?us-ascii?Q?A3wNHUqbNHx4VGUBmR1SnJPblW7XyazoNkgUKbIqvF63C8WNuzfUALUkzCfm?=
 =?us-ascii?Q?4OhRr6lwFJHPeL7SR4Olr8oulo1xmiXvUpk9kzSNS5CtOj/i2uGQHB0oGNBN?=
 =?us-ascii?Q?vPzC83jvoz/gqV7OHNnHzVoo5vg8WECTzDMoeORbR8MVksYDOOSE16mQF5BY?=
 =?us-ascii?Q?XRkfJfbEaT32S2rxDxkkFN/97KfhhW5PNEZkjvvosTktqvI2LCyxCF+fhqBA?=
 =?us-ascii?Q?e4BuYDyoTRTfLLOLK3CehACPs5qtGOMXcHt/hZODjUbpeji5bm38o1haOeo9?=
 =?us-ascii?Q?3ruOsapsVwWq9fr3/O1dNPRwcCmyxMtyXw38+270tGPwL8Iu26P2quHdps10?=
 =?us-ascii?Q?rKxwwp2hv76z+7fYaURbxztXAMCkyJ7WggzXPg9eXA5C6WDhTr0H7JPH5/ou?=
 =?us-ascii?Q?bNXmg/XGdxWLNgk3TzpCq7xB6BQiqDTlLzYtFQfx2Q6gOZm+Mq4MvxTksI0U?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE011C6E0740C8439D84D75F5184CF35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb916d6c-ddd0-42c7-cf94-08da69a6fd55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 16:51:56.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIKkmtxPVTXQSW0p1hr2twzVEfFZnA0ck2hz+F5AuMV1tNVx71GpA5qz/DoLG6hWJsB0GO68cXd6U7O6CFQ10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_04,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190071
X-Proofpoint-GUID: dFiKjRgBaQFOy-1_vVdqEJPCypB8q2_n
X-Proofpoint-ORIG-GUID: dFiKjRgBaQFOy-1_vVdqEJPCypB8q2_n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2022, at 11:49 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-07-19 at 09:18 -0400, Chuck Lever wrote:
>> I discovered that xdr_encode_bool() was returning the same address
>> that was passed in the @p parameter. The documenting comment states
>> that the intent is to return the address of the next buffer
>> location, just like the other "xdr_encode_*" helpers.
>>=20
>> The result was the encoded results of NFSv3 PATHCONF operations were
>> not formed correctly.
>>=20
>> Fixes: ded04a587f6c ("NFSD: Update the NFSv3 PATHCONF3res encoder to use=
 struct xdr_stream")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/xdr.h |    4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>> index 5860f32e3958..986c8a17ca5e 100644
>> --- a/include/linux/sunrpc/xdr.h
>> +++ b/include/linux/sunrpc/xdr.h
>> @@ -419,8 +419,8 @@ static inline int xdr_stream_encode_item_absent(stru=
ct xdr_stream *xdr)
>>  */
>> static inline __be32 *xdr_encode_bool(__be32 *p, u32 n)
>> {
>> -	*p =3D n ? xdr_one : xdr_zero;
>> -	return p++;
>> +	*p++ =3D n ? xdr_one : xdr_zero;
>> +	return p;
>> }
>>=20
>> /**
>>=20
>>=20
>=20
> Nice catch. Postincrement operators strike again!

The original patch description read "D'oh!".


> Reviewed-by: Jeff Layton <jlayton@kernel.org>


--
Chuck Lever



