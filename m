Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B15708C1
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKRSw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGKRSv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 13:18:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3C212761;
        Mon, 11 Jul 2022 10:18:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BG1EC4019414;
        Mon, 11 Jul 2022 17:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qtrHtQlsLFpi9exo8AfvMLBWhCQ1Nn3nTtRycv65UQw=;
 b=n1Xn1uOpUxvMb15F65pbw5U1iADXu7fQsdZ/i4WDJwp+B4qqxwMM9jfNDTFXGxZAg4w4
 8hKE6Bm6NuIDmriXqVnw+R11d02CO7SKmZHo39fPrzt/Xo1bwV1ZyBPRRRpZmjRINc+D
 CRW5g7VW37q4l6kTp1vtiE8RnoiZ7xw+VWFTO6w+TPe61MOcEmZU5dmXxUnMx+nWK9Ut
 fR3I68TubktEaigehD2CxzqRYAe04PHra0mE2Fk65GUkZaoVRZQBjY9sGNoX8tc8UxfX
 gOXI6usuuV4hCMkZgS9QBWnppgswLrJpFzp2zcV0qvtNvHZs4M805F5Vdd9vcPXi6tnt eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrc5yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 17:18:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BHFWIG001069;
        Mon, 11 Jul 2022 17:18:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7042f4bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 17:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1GgwPbOI9ST2kaj2ZNmMI9L/eKGRmaKx4f2g7jZoiHlO0OxfJKzHfUbLHoL1Lp8R3JBkTOGJShmZTHbF0K31Rvk4HlV4TXVxSh4+obnu46N8c932J66a82LF44cPebrGQBIAmsNOAS1eCR7oCmsTUNN3bZcf9kaXAf7JcSDI/+V/dWTZ2cyDyT+Afy6wxT2UXX2eNr9KbhjMfuJkTuySsyM0EJe11oT1KMSLMqHVJHwaRHXgGdPZsAev6TS9EFc2E3NPQ3UCVIIPIg2Q6D4yuahy+tzy0oL27onMZtpyjpaikrz7JGiekPFaPZYDRLoOUlRn0lvi7JLiY4Viineow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtrHtQlsLFpi9exo8AfvMLBWhCQ1Nn3nTtRycv65UQw=;
 b=UF5Nuhj9b6gE/jR6mZ1LW/o8sdDCtdPqkw6hnjviWYSVTyPWncd3dZLPhUIeZm70pjJK3mTpnGv9ea7P3oaPv/cwTJ1jy0l6GCoUEmpjNfqzIHyDLsGlrRqrTzt1594IPf27gEeDYisabVBkiWS7jtudLJVp0MevzY2KgGM1sl/X1M0C5Zg+jxroDxbuMzdRvJx+E13Z5uIlLL7MvuvsZReukc5Q189eyKzT0zeRiZPJsmcZv6H1WH6FoihLGREFJj5RxYNvT8zgfEV6wgew6NxbDuBxB3dOaBb4cwLK1jhLZR6ogih9iL0JME2iMTqAGJIqh32f+jfVEt62EY80dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtrHtQlsLFpi9exo8AfvMLBWhCQ1Nn3nTtRycv65UQw=;
 b=iRKTU5ZZEwjuCqLXe/yWf1zUb+fZd7HObNDVzET8NCpyUtHPlRoo5eyiHrkrEvt60+/I1cNVfuIS7XWSRN3vFO/+aGR1mu6HEQS0GbjpQVTANp/b/kAlSc2wlxQ/0vG1Zn85vEcBVfYxmO45fimTBBU4x7qWT4i0kNgvcxQDw8Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 17:18:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 17:18:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Igor Mammedov <imammedo@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Topic: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Index: AQHYlI1Yu1IMkeKgwEG1/w/Jb2AUD615alaAgAABEoA=
Date:   Mon, 11 Jul 2022 17:18:38 +0000
Message-ID: <A4F0C111-B2EB-4325-AC6A-4A80BD19DA43@oracle.com>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
 <20220711191447.1046538c@redhat.com>
In-Reply-To: <20220711191447.1046538c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2910f67-7c65-427c-ef99-08da63616512
x-ms-traffictypediagnostic: CH2PR10MB3960:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yPtqCBfEyq0ZviXT9akUEf+j2pO8MQsjhR+i3rEBBojg/sms25qx0SEb2fpuDOUGRu3mvTIRamdSfU5Jy86Y6jF8bQ+HYQJ/WSR9am7DZaNdTNcYjGq9IX/v094QmmRtr2zQQmbbnAKkV/FLjpnsGPLj0dHoxzbPAXMgw/duaglpspfaUkfPuZD06eVs1wVav3gG8J3ODx3DWtU5flFFkV+P5M/9ID0hVN6W8JtAAIMmpqibAv612zMXZk+NMWQnu9XMZWPv+PK2iy4vFXlEpLj+XbOnY45mb7tACs52ol0jjsK9AMUNmo20JG9/ig0UdNhQS1HnUpUPiNlRfC95CT9mExD9nRWnJN67xKWTAnEWL7BGo8GeAqfWuPkpvefeL2kW5dENEYd+sEw1/2cfer+Pd50ACvWa5FXyiAnwGEgPwE5Xz0emy0rabRLqCna/nkxMIUxorT5HS8CqW3WIhhWl4GREPyqrcK28OONx76A+nAfWkPmV9BAOfvllL1JM5cg6zfCQa3U1y6pD0LweaxdoAAiMNPTMlWkqxZDj2LmELpcVa4hthYlRnyuYGKFQFoxMl1bbdnRbI+5V6hUdEWl/5BCl6r0t74yVppCXi5D8Rj0wKi0XSZtaS+uXvgHfprVVqdRqFTLo+nDk/Q34W+leQvFKJSafzA3akWDZLNx290ARzoymRQgXZkT3QYxVAYBTZbDqKcNi8vtAIoXnrlkMsVYoZSD62H/Wps4RGis4wvRoZTiFy+QBhN07irWY//vTUZ7iM7vI0xdmUroShJMDUQitc7N7tE3f+H1/4tCBmnyA8iKvwEXQwk/WgzBv8CdbPsuM6fWgXR2ox9LAks+UdDJWGv+tE5pQeDXGZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(33656002)(186003)(53546011)(91956017)(6512007)(26005)(2906002)(66556008)(66946007)(2616005)(6506007)(122000001)(86362001)(38070700005)(38100700002)(66476007)(83380400001)(478600001)(6486002)(8936002)(54906003)(5660300002)(4326008)(316002)(66446008)(41300700001)(36756003)(76116006)(8676002)(64756008)(71200400001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vh0NiVN8mq3kVoc93spNvVMoa1JadeuDBfPokDfLKJXjoYlrt5onkPnc4FBp?=
 =?us-ascii?Q?F49Tkp6ZeIxHu0MyBxHAry1YDTs1vKCCzeHAxzok7NMkbi7btJ/kQG3Hh5pu?=
 =?us-ascii?Q?Unkd51lMlZZlHiokXXoI/ygxAt4a786F3zkK1OVKXCQTtQ7GRJp8A5FjhesC?=
 =?us-ascii?Q?GubD/Xh60SSBoIyteQ3h8SeqKZKx6ngiLfEYA2lW7u9PmuaLtNrBw5clGGX0?=
 =?us-ascii?Q?MaZqOkww5Y+vrJsuGy2+EtPRzBD9XAoiqvUzy+ruCsjyXGVZ1FykvJIKKAEv?=
 =?us-ascii?Q?mC8pJ4JqQHpxfu4RutP8S5+jWmfKslOgLgkNGfL9bl9WDInc4eaSn2XpbkP5?=
 =?us-ascii?Q?8ghw2hNGUme5CnaK/aKedI8E6MJHyds6hZhmLnxNBPJk91Pmf18jM/OTNSyF?=
 =?us-ascii?Q?L2xwCnQmcRyvCepmncGLRoOHR5wu7zkCvOX7GvH4/9UdhlcWgTIxUJfvBJRa?=
 =?us-ascii?Q?Cm2SZn+o9360mWyD376/O8riYpMngWdNMNNyMYMOb9zWY8SidDxCJHMKuVe4?=
 =?us-ascii?Q?JfUnj1UYsRJpClH0jqq/XEA4xoZsVcO6Pk8SsKoIW0qFKnxsINx1/l7GJGMm?=
 =?us-ascii?Q?+6vzCZIOlvA8vTqSV1qfLPb1bZM6DwSipz4BME5if0jCXvTResIkO8pPkfR2?=
 =?us-ascii?Q?IOyrSfPI0Tgt4vMLwVekyvLmKKayo1YDbD6MqH/AkrpiyKQIWu/IhS/G6t7y?=
 =?us-ascii?Q?OxeM9QcpSt/fyYXqvKzbMp3uQFMct7Je8JixVHU+TfBzdQD5fDVx6vDULoiT?=
 =?us-ascii?Q?wGsXgScfIwNgLoWqFtKKAAGlobf31VV7Zixwlu5Gxl9eeJhgJl4K7s7DivWY?=
 =?us-ascii?Q?eVz68sb/KkHXfVOTWulYAZCPreg63SzkhXfEd0Lsg4Hc1laM7ImhuNreBm/9?=
 =?us-ascii?Q?4BglPBdyocJgK0eIDJrKhW8VDuWc5XNXb7B8M/ntiSFjzMKVaIufCsfL1ERB?=
 =?us-ascii?Q?E61DkdPmRpeOzXjXvaYpvKwywtCNqiLcBItpoXBLgiPQTzeYEVDde/GDNl1B?=
 =?us-ascii?Q?8l9tVYIudc8L4B1ZKC6hz86lDU6x7Af1q2kt+MpTmPjhTffbd02nN7fZSZVK?=
 =?us-ascii?Q?Ns3EpOk77r9Nlu2Ve/FcDdtnbjXBrmYPhr5BCKQ0sy8VmpDMTBJtDc+Id0Et?=
 =?us-ascii?Q?5vMvoNiQNIXYFb1oaIg7iptNzESHBJ95kS4FduBEF6AOliKohYpAcL/qL6d9?=
 =?us-ascii?Q?DV8XLP0u78Wp+VyLXwhp5gAgewe2B/U/+L4G5csWkSRjd37cF+YKCRYhGwEE?=
 =?us-ascii?Q?ylRY0Hht/Pw8yoA+nVr1qDFpJ0YBBFoCNZQ4Xu+Q7kz2wwgnWjZ+GQKBpCzf?=
 =?us-ascii?Q?4OffwYx3XCeAgSjke+sK44St75zjyxVOz2EMPJz3e4LCIfdd5gkHeEV77//C?=
 =?us-ascii?Q?3yNVw89KL9Fy6B0489LMZz+bXLZ4DeEaNB/scUoVcNplB6Abn3ST10AJBc5e?=
 =?us-ascii?Q?W1dGM5XSgFH2MDIuwE+9YA0K2lkpUnZLx0RDxD9rmrwNPSlxL0JoekdWe4OQ?=
 =?us-ascii?Q?lHUAsFph/iohklVgzJbmlCqjzPvYbo0v2IAtyX4bBhKqAg8nZ3t1nBoqOzBh?=
 =?us-ascii?Q?0+vXxTfISdq2je9qstuwTeRNjB4NGb3wg2Gu1M6hHLiS/3UY1Ht6O2sHbc89?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84857339ABFA7B47A2CEBF8AAA67F371@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2910f67-7c65-427c-ef99-08da63616512
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 17:18:38.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voYDYdIroaQrH63nXfXhO0Kvt/WD+14xpx//rE6W3NNALl3yUl9wg4MuSy9f/0yFkYHxDS6WFjVhgo5d9kHKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_21:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110074
X-Proofpoint-GUID: yyAd4WPxuVcBdwcRxLWK4wISTWXjCeOK
X-Proofpoint-ORIG-GUID: yyAd4WPxuVcBdwcRxLWK4wISTWXjCeOK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 1:14 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Sun, 10 Jul 2022 14:46:04 -0400
> Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
>> NFSD has advertised support for the NFSv4 time_create attribute
>> since commit e377a3e698fb ("nfsd: Add support for the birth time
>> attribute").
>>=20
>> Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
>> birth time attribute via OPEN(CREATE) and SETATTR if the server
>> indicates that it supports it, but since the above commit was
>> merged, those attempts now fail.
>>=20
>> Table 5 in RFC 8881 lists the time_create attribute as one that can
>> be both set and retrieved, but the above commit did not add server
>> support for clients to provide a time_create attribute. IMO that's
>> a bug in our implementation of the NFSv4 protocol, which this commit
>> addresses.
>>=20
>> Whether NFSD silently ignores the new birth time or actually sets it
>> is another matter. I haven't found another filesystem service in the
>> Linux kernel that enables users or clients to modify a file's birth
>> time attribute.
>>=20
>> This commit reflects my (perhaps incorrect) understanding of whether
>> Linux users can set a file's birth time. NFSD will now recognize a
>> time_create attribute but it ignores its value. It clears the
>> time_create bit in the returned attribute bitmask to indicate that
>> the value was not used.
>>=20
>> Reported-by: Igor Mammedov <imammedo@redhat.com>
>> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> Thanks for fixing it,
> tested 'touch', 'cp', 'tar' within CLI and copying file with Finder
>=20
> Tested-by: Igor Mammedov <imammedo@redhat.com>

Thanks!


> on tangent:
> when copying file from Mac (used 'cp') there is a delay ~4sec/file
> 'cp' does first triggers create then extra open and then setattr
> which returns
> SETATTR Status: NFS4ERR_DELAY
> after which the client stalls for a few seconds before repeating setattr.
> So question is what makes server unhappy to trigger this error
> and if it could be fixed on server side.
>=20
> it seems to affect other methods of copying. So if one extracted
> an archive with multiple files or copied multiple files, that
> would be a pain.
>=20
> With vers=3D3 copying is 'instant'
> with linux client and vers=3D4.0 copying is 'instant' as well but it
> doesn't use the same call sequence.
>=20
> PS:
> it is not regression (I think slowness was there for a long time)

A network capture would help diagnose this further, but it
sounds like it's delegation-related.


>> ---
>> fs/nfsd/nfs4xdr.c | 9 +++++++++
>> fs/nfsd/nfsd.h | 3 ++-
>> 2 files changed, 11 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 61b2aae81abb..2acea7792bb2 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp=
, u32 *bmval, u32 bmlen,
>> 			return nfserr_bad_xdr;
>> 		}
>> 	}
>> +	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
>> +		struct timespec64 ts;
>> +
>> +		/* No Linux filesystem supports setting this attribute. */
>> +		bmval[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
>> +		status =3D nfsd4_decode_nfstime4(argp, &ts);
>> +		if (status)
>> +			return status;
>> +	}
>> 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
>> 		u32 set_it;
>>=20
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 847b482155ae..9a8b09afc173 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorver=
sion, const u32 *bmval)
>> 	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
>> #define NFSD_WRITEABLE_ATTRS_WORD1 \
>> 	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
>> -	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
>> +	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
>> +	| FATTR4_WORD1_TIME_MODIFY_SET)
>> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>> #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>> 	FATTR4_WORD2_SECURITY_LABEL

--
Chuck Lever



