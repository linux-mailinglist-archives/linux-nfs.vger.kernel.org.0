Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2855151E358
	for <lists+linux-nfs@lfdr.de>; Sat,  7 May 2022 03:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbiEGB5F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 21:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiEGB5E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 21:57:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1FC61628
        for <linux-nfs@vger.kernel.org>; Fri,  6 May 2022 18:53:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246LTaUs025194;
        Sat, 7 May 2022 01:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xWqr8jSTaF6r8tb/HjaEE2QupdxZfIeoPgsvxZZCKaY=;
 b=QB/pJ0kVrZpATRwtBLiPMAIeBX9foEgr6/gQ07T8F93ZeM5gme+mGUhJACcEzqEw2FWy
 eAUwWej9e9yNWk0rMe+vWhB0zcG8UW4Hs1OG9M2Nu/hB0nrSD0g1JtC0tOgNMeeM7ckh
 XzFniWFre7mvEPxiaUjlHA9udwD6p4asVk1kzMa8E0FOihmgqvUqbyRmvUOJYODV1IKq
 enAK22CWm1wYyR/d4CGcPf0uKV0xZj1eAUydFMIqUPKXz2l/nCgtrdmL0ppDn2bEqy+o
 obuUpHG20WW/9/4nx/d+Yfe1OFKmImFhfWW0MP+UwoplFieLoIrXR0BXZTnmJ0JE6GfQ 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2qe0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 May 2022 01:53:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2471pQpx029347;
        Sat, 7 May 2022 01:53:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf700890-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 May 2022 01:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsczSAGo1T9RsXSgXk4lLCSu4TcuMj7X7faRvUnEA4cq4e0YwWWf16U1yQEafRPteotlnlpTLetN3VLxPcJX+gwgfF2gCbWf+AFJ/tcGp5nlTrByEJ80BkX4f+CnZ+gn5QI3tMuEzVbG63JIMCylRcJeOhqHDLSdB33aBROiyFGw8kHbXNRnw1Ci5bnRFPdUjsjPuvkaj54g6dawwLgjP9G+tRaLShHWNFvrfAFm4d/hdaHAid4Xr6Yo5CZDMcsXmbE77BnpBiUDkzjrUNlhOBGJ4ctEGnn3/E4in7wHu1aJU/NCrLSK4xbmNfmyxxvs/SB1Euvh92+WPzDsRhMgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWqr8jSTaF6r8tb/HjaEE2QupdxZfIeoPgsvxZZCKaY=;
 b=XpylMS7t/xU4iloqO4JzeU8g/8Y0d+yasLbr6uw6sY8qBfhMgfmSrBBgeIanHxHN1BRdURLyF/EM0/oT12ig/S7K+zQSk5J6/k9UQQ9QVSw8nmtrt37KkuNSWg/PHyI+eXoDiiGTArljkZ1E+fkoYi4nMVXzozcxXV+6YJXFkVlT1saM6m9Y8Ift2yE6tYs9xV0gu/nLr+M6CK1nSf/im+rNwtgQzuH9zuzarmPjSlHWwzGFg6J1L3lLVsEhZPfrRIUpsklWnUia2HHXo3hj6KygW2opyBed1GreNbgLlT6thxL1PJxF2WrgLU1Vd+NaJk9a42WcKaLEKarMwGeQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWqr8jSTaF6r8tb/HjaEE2QupdxZfIeoPgsvxZZCKaY=;
 b=zMXbvS3AxJCiup/pO1bXjovsXrRCPrk3WymBiFpYe6bmhQhU/hFEU9Mfm3r+lKMkXSgeQXqOrLlNcYelYnhWhfaXDRr94z2NXYgizJ9PVmZfs0CpLMenISS82/fSSbpa+cPrLLtHmzevEa31N/6/C3Kdqmpli+YbrsmKCjEGwA4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2114.namprd10.prod.outlook.com (2603:10b6:405:2d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Sat, 7 May
 2022 01:53:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 01:53:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "andreas-nagy@outlook.com" <andreas-nagy@outlook.com>
CC:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw+AAMzyz4AC9oCjgAyG2mCAALz5gIACLUaA
Date:   Sat, 7 May 2022 01:53:09 +0000
Message-ID: <91B9C47D-586F-4352-8484-730C8362CD65@oracle.com>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
 <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB166592CDF7C78BD68CC153498EFA9@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1665FA51F62F82B006FD97168EC29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <D267ABA2-A071-4406-A218-919DC7414DCF@oracle.com>
In-Reply-To: <D267ABA2-A071-4406-A218-919DC7414DCF@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 725d1727-12da-4f97-cc90-08da2fcc56a1
x-ms-traffictypediagnostic: BN6PR1001MB2114:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2114CB64CB6E19E1E46A1D3C93C49@BN6PR1001MB2114.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k20ZZqTjR8jYh2hvDUDKzk7PIStJTnxP1I4aFXIWE0Y1AwBw2wmyXlfcvhE5uALstjg1EtGpsFo04HNfb9eR5+1MBs2hzg7mivCIGoxP9A1TGRc1RMC/p1QHVuD0QfhWzHVeSOS8RSjO87kQk6vMN6JwvXRh5JA101zhuCI8iETl7QmNdALzSC0XNg3cap7kvsfmznZTD+IAi7uTZMBAKKXcZXUX2X2cE7fthXMkfUNp+ts7MY7blz8faykUamzHE5pT7Ipw2EHLm0f/pmDhvPXbOc7m7pcbgk6jdoqU2QI3YcgIlcf2zH3O+OV6M2Cjeghd+yYC9/u9CSTE9A0ogis4MUCfCltqyT0M09dAZEc2GbImZuN1NKIlfA+YVV3ZT6vuO77Id0cnRtio4uJA5U4SiBVVuXV2VbkJkIe267ND+0+9ncZCQ0HszQ6IDLcb6vCv7DRTWqGptl5d1zfLbrHWCywRzMAParATuSJx4AuJfgb0ru6Kb2uFnheXGVxBqeLdNLpc/IwshhHXxIKQxiidOIgGQ/x3ZwrB6MKGj5RglB4gqCD3fdbZk2qqILSJubPi1zZbfno5WJD1i1i+U6syqMTHzelu0LUTQCE+9zptaDI3M/vJOaQp21XYT4uOWyWe4UiSjMiNYvY+se/shG/SB6bM1jS1MJTiUnQHDAP6VtidjkSQxp4cLbzWQqlYLNgW3AuoMNCIC1WLi98PMpAVtUIXOiRTL9xkxSmOvU4IaIGBNTntpZ78mrABjLwH9BgapJ1iCFBG8u7ivy/cqdi24kOcbo++Ecg/xKP4uzG6mdIck/JQRAMsaiPX+PFe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(33656002)(53546011)(4743002)(26005)(2616005)(6512007)(6506007)(186003)(36756003)(45080400002)(66946007)(71200400001)(8936002)(508600001)(6486002)(966005)(86362001)(2906002)(38100700002)(38070700005)(66476007)(6916009)(316002)(54906003)(66556008)(91956017)(122000001)(76116006)(4326008)(8676002)(64756008)(66446008)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y4d1j9I6GNOOE2aZrgadf2pEOnDXU7BhmjAdSpLbXPWbPnDj7Dgf1tD13sgd?=
 =?us-ascii?Q?fyN0L8+Zl6wLRHF8Kb0Xu9Nuxxdbf44N/kgVfyEdPitTK4ogVZ2XiDavSWiP?=
 =?us-ascii?Q?QCtaqrPdmCaR0XVyD0o5grpmzrZbasUrbts9Zv6ep8qtmzHGga9+JpvyGFup?=
 =?us-ascii?Q?CJP7m0NoKpu1CKoV3tUvjN4mebRZk9zkfuRTHXJ3p+OQ3hTGGXf19TmV7ZJu?=
 =?us-ascii?Q?aVYHMKaakr9OwMEVi9DJHmo+WQVRDV6dsSdcannG59YTVqEBdPPwK6/pIgDZ?=
 =?us-ascii?Q?VYflx9+R3OcGSUBvYVXKEuWxIDhQyOL2fa0uG0Q5nLKiO0Zf2l7ldq79881n?=
 =?us-ascii?Q?qgAlvxLX0A2jaHCUCUzBZEqYltU+3SIGV9dka40u1iP0WXgY0aNvtJuEo8TO?=
 =?us-ascii?Q?8Mdg6uC2R8TTHqHoNDkvZjhYZ0+F2MWAiW8MudphVV2OdSuOYc7XrOuACHQ0?=
 =?us-ascii?Q?C5GruUGXaWqgpx9GDLB6Dhp0BqhrmhzFxu77Gp4d/4FIr297a4fKwd/05qSz?=
 =?us-ascii?Q?kLnaAFc2IFO0sRcvSuJdovCbQyOk14gEqHUTXvw7igoXcFD8SkqttQnXRZ+s?=
 =?us-ascii?Q?5tuMiqfZDvWeA4N9ZgCkzdRAZRLl6wgG4kkPhQ+RYH3u73eKPezuI8FlFkbr?=
 =?us-ascii?Q?SGLcWMRqw1lXsIpIVmKcirV/qj/XxCpCuMzrSuG4ou0tbfb8UoqZlxbQ49oo?=
 =?us-ascii?Q?TV+M8ho1iyHoBoEvkMXwHK42cVtjlJnZnXpe1blVyZKo9flbt9oC537Zjek2?=
 =?us-ascii?Q?L/PLQLe0jRpiDKLFyQh/JYV+xS6lbLVhZBv6kE/iFB8IwZ5VxK8nFV29Pudy?=
 =?us-ascii?Q?7hfu88M+NF5b0g3LcTfc1oOfKgMGBBy4EfpWxuk1NAKP7P3ZtMDhk2S/u1j0?=
 =?us-ascii?Q?oea/SsHFEVYsOY39vtIuqFlRBk48YwRteXKsy0ktLjtaxwbC+JghnXzCnGQL?=
 =?us-ascii?Q?7zJFZoXt+TfH1FIlr7wpm6EClrGco+6PnoiF+8vKTNYY7g9YWTeOnZ+empzp?=
 =?us-ascii?Q?OHdOT7AGwZ3B6ZgUXPJdXTOFfqmBwc+Y0Nc8VkD6GjwtPcAya92tJ74tC252?=
 =?us-ascii?Q?2XfIYrub8yZ/KJRQitwetoC7x4tmiOea9YGOH2ZyUHkri/d6IrGLUN/+6hkS?=
 =?us-ascii?Q?enaICCm0GCZRoLpu1CPT9bqyJln9oIuPV6rxLNVkBLnLT8b/4KsdZFS5XODd?=
 =?us-ascii?Q?eIeSsZ/nBRZ50uca3OioEZ5raTMHO5UMrsc1wELOaF0rxVZfJCl7+r+yuZD0?=
 =?us-ascii?Q?tdl2UJxftRjHKY/besZHCAKrcaZxxUvEjrAZw5x09oSWhR/Wy2hQ3urkaBVx?=
 =?us-ascii?Q?PLf+A8y0i3lRhNC+eJwhsGOlR+JHLsAV2pRNk2U7ZJlPKwufy3pKmi6rzNS3?=
 =?us-ascii?Q?uxGarFnTrrbjRJ9GPfpLAOryQ9kmsPTuXvZdZ+ZYyUjSmLGJK4/MXfqst2+R?=
 =?us-ascii?Q?cqZcSPqT1XN27c/ofav/WyCiZZnlx00jpDBkM1k4MrSTu5UpAOr8xc1RBpfL?=
 =?us-ascii?Q?4aOFRucFHDzgWNkp3FvYO/gdqHwlkoG5PD0xaJrFG94Da1p8Rs4pCCnQPk0U?=
 =?us-ascii?Q?qP0Z4NeyNEuU8zwNDawcwgTLwSOmN/RglK3ixr7qY+wzySTiUId5H6diT2aP?=
 =?us-ascii?Q?ZIp9FENm19afYxc1NvpCV9WJfq+572BePwRwTZhwkZxmNFOIgcuhQnI9VSg9?=
 =?us-ascii?Q?5lr3Tgn5a8Q8cNn0nhXkWUZrmF/Ct3TM+cNzysZlXJnzYyVH+FweyjAqsEuI?=
 =?us-ascii?Q?+3b001vunnx3xr6rM/LgXHbXwvLPIa8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FA340552E658843A71012672C65B618@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725d1727-12da-4f97-cc90-08da2fcc56a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 01:53:09.9131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3TtaSW45ywuMoV4Q/+nwo2vX+V05TadGh08UyqGd3Vi4h956s49omFCj2mghqH1sc151Q3Y5UV3TyNBrB1v3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2114
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_07:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205070009
X-Proofpoint-GUID: Ncox3P37QjJoYCMoPB9fNTa-1zRbImGO
X-Proofpoint-ORIG-GUID: Ncox3P37QjJoYCMoPB9fNTa-1zRbImGO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 5, 2022, at 12:38 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On May 5, 2022, at 1:31 AM, andreas-nagy@outlook.com wrote:
>>=20
>> Hi,
>>=20
>> was someone able to check the NFS3 vs NFS4.1 traces (https://easyupload.=
io/7bt624)? I was due to quarantine I was so far not able to test it agains=
t FreeBSD.
>=20
> I don't see anything new in the NFSv4.1 trace from the above package.
>=20
> The NFSv3 trace doesn't have any remarkable failures. But since the
> NFSv3 protocol doesn't have a CLOSE operation, it shouldn't be
> surprising that there is no failure there.
>=20
> Seeing the FreeBSD behavior is the next step. I have a little time
> today to audit code to see if there's anything obvious there. I will
> have to stick with ext4 since I don't have any ZFS code here and you
> said you were able to reproduce on an ext4 export.

I looked for ways in which a cached open might be unintentionally
closed by a RENAME. Code audit revealed two potential candidates:
commit 7775ec57f4c7 ("nfsd: close cached files prior to a REMOVE
or RENAME that would replace target") and commit 7f84b488f9ad
("nfsd: close cached files prior to a REMOVE or RENAME that would
replace target") (Yes, they have the same short description).

I need to explore these two patches and possibly build a pynfs
test that does OPEN(CREATE)/RENAME/CLOSE. I'm away from the office
for another few days to it will take a while.

Until then, I guess reproducing with FreeBSD isn't needed.


>> Would it maybe make any difference updating the Ubuntu based Linux kerne=
l from 5.13 to 5.15?
>=20
> I don't yet know enough about the issue to say whether it might
> have been addressed between .13 and .15. So far the issue is not
> familiar from recent code changes.
>=20
>=20
>> Br
>> Andreas
>>=20
>>=20
>>=20
>>=20
>> Von: crispyduck@outlook.at <crispyduck@outlook.at>
>> Gesendet: Mittwoch, 27. April 2022 08:08
>> An: Rick Macklem <rmacklem@uoguelph.ca>; J. Bruce Fields <bfields@fields=
es.org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
>> Cc: Chuck Lever III <chuck.lever@oracle.com>
>> Betreff: AW: Problems with NFS4.1 on ESXi=20
>>=20
>> I tried again to reproduce the "sometimes working" case, but at the mome=
nt it always fails. No Idea why it in the past sometimes worked.=20
>> Why are this much lookups in the trace? Dont see this on other NFS clien=
ts.
>>=20
>> The traces with nfs3 where it works and nfs41 where it always fails are =
here:
>> https://easyupload.io/7bt624
>>=20
>> Both from mount till start of vm import (testvm).
>>=20
>> exportfs -v:
>> /zfstank/sto1/ds110
>>               <world>(async,wdelay,hide,crossmnt,no_subtree_check,fsid=
=3D74345722,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)
>>=20
>>=20
>> I hope I can also do some tests against a FreeBSD server end of the week=
.
>>=20
>> regards,
>> Andreas
>>=20
>>=20
>>=20
>> Von: Rick Macklem <rmacklem@uoguelph.ca>
>> Gesendet: Sonntag, 24. April 2022 22:39
>> An: J. Bruce Fields <bfields@fieldses.org>
>> Cc: crispyduck@outlook.at <crispyduck@outlook.at>; Chuck Lever III <chuc=
k.lever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>
>> Betreff: Re: Problems with NFS4.1 on ESXi=20
>>=20
>> Rick Macklem <rmacklem@uoguelph.ca> wrote:
>> [stuff snipped]
>>> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but most=
ly
>>> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that
>>> tries to subvert FH guessing.
>> Oops, this is client side, not server side. (I forgot which hat I was we=
aring;-)
>> The FreeBSD server does not keep track of parents.
>>=20
>> rick
>>=20
>> --b.
>=20
> --
> Chuck Lever

--
Chuck Lever



