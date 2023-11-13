Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04C27EA124
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKMQTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 11:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjKMQTW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 11:19:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC51702
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 08:19:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADFsBjM019284;
        Mon, 13 Nov 2023 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eGVdYW28NROkdAA+ni51wwAH8ZvWZaP02xHle7BLLcs=;
 b=bUiuud/Ocpn9r6DTI7PHJZ7IqGoJsSTdZzJGIQ/kvCg1bbXSfkSThg47MfFA/VQwuDSY
 GI6/MhqcH1TD8gFW94I+I7AYmZqkwpT30PRgtKa25P49N9j6MhbT5r1L9gjHRw3wIqSq
 xxQDqbj9ce6sLHIwFrz6I4x2bq0dZApALj9tvC0SCRkkcOLd07zs+TafYPTXNbDB8VXR
 lFN1aAgzzAf327UgqbvZJ2w4fptqMtJPBLgKKj9t2+kDVJBBXHJmeKf8D8WCF9uidYkT
 P8fppJzo3kyZz5GY9qY6NyAH9P/vilgpFpDnGZ+cYzFpr1lcXD7eWrZnYgEHkv/iXrtY 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stk5hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2023 16:19:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADGIRoZ015113;
        Mon, 13 Nov 2023 16:19:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpun0mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2023 16:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCihCCUEgeY6c1RLE8gE2vt31yDFLZLtRsnY+ytl4AJ7R7QfjheJW78a8MyqYvLVQR15aVwo0PLtuCgoX0xs2HCMwFGJ9ealonnDFMSIUUkEPVy9lTv5jl2EEaWtFx/q9kev1gG0PMiuhn0GSgG154+2fBmlV7wOPASWIQG6bR1MX7cTonHPDp4/y7q9AlJxJtzf1ooaJ0LUnwXuVE06MYAgVDbzLOsEEgT+5GipuPcQ9w1RKY9ipy7uGa25qCCCCe+cs7Yt7aAEEtDr3kESy2j0aNxZZIq34hMO5St/9DaFY87bSM52Ci5MZNp06QMZQ/NRI+WSnArtRNMrOyi3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGVdYW28NROkdAA+ni51wwAH8ZvWZaP02xHle7BLLcs=;
 b=d9o7qDiWp6LpUtk3KWhZjb5vx7HFprjgd6Cp87/3v7H2P7qmglME2VDVD+/ihUg4Te0I8iG2d5UgYteNS1TZrZo7bhYkvc2dVNCRW8GqUFVVBFcAZjMfxH7oIEtXJNoL5ekjmCa+tpFpqf/JW88hPNRzv59nkE2FsavYjIHMpnbOmtMC2eacsyOakyLOm9KwAvop1PN4aY1aHPaG6RvMnssBGtgBkB+Hy8S87Oex5VG/jII3ehOuhsOqTceiz9tam9uAIgK4POOmqx/vovYVR5o40r+ZDGI4gGd4mNTv1vFHrFwHT8b2C0Ru7DdfDRGJYdELpGuCMC2887H7bgRAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGVdYW28NROkdAA+ni51wwAH8ZvWZaP02xHle7BLLcs=;
 b=v2x0wDdTxaoB2ToRAfSluBBGUPGqGLUY3MqVUarVmy5l2peeOR0Xor8g4RzuZ17jEe7ZfylpwFM3lFC5y/7YhfZc1h6iaMtqh5ZFDb5ft4Yw3NPly/5VNeAikLLTUO5u3NVtmD6U4BifoOCcUPhizjhccgpmjpugKab8k6d5geQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 16:19:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 16:19:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Martin Wege <martin.l.wege@gmail.com>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index: AQHaDKK/5xxTBJcRKkGtisdr07fPibBlifCAgA2y6wCABUQbgA==
Date:   Mon, 13 Nov 2023 16:19:14 +0000
Message-ID: <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
In-Reply-To: <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5540:EE_
x-ms-office365-filtering-correlation-id: 7842fb7e-b879-41b5-f130-08dbe46446fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQKARjaCSj3u8NUkNzxI7GusIA92GN2UWqgKJSnf0YKx9Qh/5xyzozkUlnAQ4XPWQ5n4eEXpZ6pBnlZ53frr+8yo09sScL2ba6oZ5/4FpH2P7xv9vVlg1AesszZUYPgWi3KD/IvKfZ1wfoAJZcVINRTf1PvS/JTtnENLA1ukDV+opx7XCor9osEvnOG9wg9Y37kjc/0QK6izzN4AlIt674Sw1JwI6HZ6fmTC7W2yh2NPajP0RaRK2K3nyX7BNxcCDM4DmCdZjCP0DadnANXP0dw6h12Yt3HLxUpZJJ2ztyGTz+9zRnVjLXpDwsm2EimohrGHe79LNvx9HABIdvU6lCU0Lvqa4AaLRt2Hr4WsgDaFhpjNKcrd+uiMS0B7XgZaVQoBz2ealkT+69WrZP8nFZU9rb9oVVCqirXudZmP+qWoBYAsRdBnqPz3HjM5CULB8HVZtfFLWxsLEYhCfADBpBBygB3DvC+Ykazbawf9VQCFVPwDHdOkme0uVD0PeZOxucxt1m6VBV7BWt/AS9p9ZnOao2meigcMKzErauDN6qgF39joEUdCpq9enTdBmstZ2t8IXB+OhtLoiki/ErnU61hLG5njMLua2CxF0nDTkvK4vG84UNxJblVC2N9v2oPgF/RtFstglQ+W/NtW+FYalqQAOBihmgP3NCPn60uhHA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(316002)(66946007)(76116006)(66446008)(66556008)(66476007)(6916009)(64756008)(54906003)(91956017)(2906002)(33656002)(41300700001)(86362001)(5660300002)(38070700009)(2616005)(122000001)(26005)(38100700002)(478600001)(36756003)(966005)(6486002)(71200400001)(6512007)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGtlTnNjNnQ5cEZURG84MWNIdjJSdlVlNVhodVh3WHJyeU9BaDJxaThEYUdy?=
 =?utf-8?B?QzVta29xSzArQm1xczh2QUN0RWhpYVNOUmR1TW9LOWFlanFOekRvalRjaGRT?=
 =?utf-8?B?clI2eXZzb1kyMXVmTzhCM1NGWVlXMjl4S2dCblhUdmhwQW1IRldyMVVESDdw?=
 =?utf-8?B?bWt5VmRLZTRCNmQ0QloyZ2FySjB4MkRYTFpRTmpwdnRZeXhwbHQ5Ny9xT3RG?=
 =?utf-8?B?Ullody9uakJLQ25xVGlybWV4TmdmT3dwU0hROVM2endqandYV2FtZUo1UTND?=
 =?utf-8?B?TEZJbVQxbFVRRFhjaGdZcnk3OWxWR0hBdzFJLzMrSEt4bEZvbUxGb1dvVU8w?=
 =?utf-8?B?d2RxeUFnQ1dJMlpuLzY3L3JKcVh1aldKRkw1OUg1YWdiU05QdWlnQlVjTjVH?=
 =?utf-8?B?a3lRdkZsK3BnNXRSQmNqekZHQkJjcFZ5WnVEQnpxdW5YOTRFUTZlN1VGYUdu?=
 =?utf-8?B?Y1JXUktmdVpsb2VZY1dlRzE3Y2xFeFFjcWQxNzMzL1FVaHdTVlJYWDdCaXh1?=
 =?utf-8?B?QzVnS216NDQ5bGpSNkkvZ0FEMjlxb011VzNpRW54TFhIazB0SmFxS1BEbW1o?=
 =?utf-8?B?aWN2VGdxTzFXNEROMnpTbERFTW5YYmVIM0ZXVEtNVzlVMm1FNk1sVTRIVkl1?=
 =?utf-8?B?VGJVSHZ3M1hyNCtKY3JITXNUbjU3aCtHdHpqdTcrQTFmSm9jd25ObHJVRmkz?=
 =?utf-8?B?MzFxSFVydk96WnB4UHZIMDA1YzU0RzlVSlpycUUydjI1NlhkaEY3ZjVLemZP?=
 =?utf-8?B?bWdrc1RQTTBoZUQ0NUlRbmo5K1phaVhrdisxU2gvdVlIWVVCRzVjZERTUlVX?=
 =?utf-8?B?Y2FVb0c4eEtIOStoZ1Q3Y1ZzRGk0WERDYStYRXlYdjNxVlViRHBYR041YUl2?=
 =?utf-8?B?cHk4ckpjeGQ1VjQyL1FUeS8rOWFiaTFyYnF1QUtEMXI5NGhrS3JDU1l4eTVh?=
 =?utf-8?B?SGZMODBkOWd3Z2xLNndaaXYrTWxRbm1mWi90c24zRmRXNWJKcDJBRlkxaEgw?=
 =?utf-8?B?SStHbS9YdFhDeUUwUTRlUE8vUkVnT3RKKzFRR2VabjA1Ryt2cFcreWpWemJ3?=
 =?utf-8?B?RGN2T0VXbEJIQmVWYnUzczF6bG1aZnRKejMwT3g4cHdwOEU4cmVycU5UL1F0?=
 =?utf-8?B?Y0dCUmRWZFpkUWY1azVjZVBNMUk3RzZFK0dBVm5iSysrSk9ZMmh0aE5Kam1N?=
 =?utf-8?B?d1luaVROdkRoY0hMNUlxZVhGam1STStEd214ckhxdzNNNFQ2L1FuYjBvVUZ5?=
 =?utf-8?B?eHZreWl6VUZOUEdncXlRV05YMG1vWW1Yc1pLMzhNTVVhSDVBM0F0R3FYOXlI?=
 =?utf-8?B?L1hIVnNGQ3dKL3NkdHhYMmhaeHhCaThYRVliS21HMEhleTN4dTRtc09vTUFi?=
 =?utf-8?B?QTViWjBEb0oxdmdJdnpzY21pR2FuZkg5QklQbkgrdDZhWnJEcFV3d29PWXox?=
 =?utf-8?B?Z1Y5VEx1dGlCNUFVM25EOHVyR1pMT1lVUUtxeHZDY054ZElXK0xsTnZENVRZ?=
 =?utf-8?B?R1gxemNvK1BYZXZqcWJ5QmNSS3l5NmZDYVU1QmU2SERuNjBHUUJyVmd6USs5?=
 =?utf-8?B?MFlUaGlNQ29jRXJmR3NUN2sxRDNGV2NPQUkwZ01RNUYwR3lySlNNYWNYc3JG?=
 =?utf-8?B?cWlZS3gzZUNCNld3blpzblZIeEg5OXNaTlVSdkxFcWYwYTUrdnpWSVlaK3ZW?=
 =?utf-8?B?Z0twUUZabVl2RVd6NXZDcjduTmtQRnlORGRFVHJSa1JLQUFaSkM4QmRkeE1N?=
 =?utf-8?B?eXA0b2RVSU1xRk1RL0ZmbUFOZU15QTZxMzhmYlFJcDdNUG9QN0IyYzZaUEhZ?=
 =?utf-8?B?S0habmNkZjZmK0gzaU1YdStZdjNhakcyL2dUTkVsdXhLQ0k0aXRsalZBeldE?=
 =?utf-8?B?RzlNWEJJb1RMRkIzMjFPMWtrQmFEcWxlTEFEVTdhaVcwbjFHeTFXeHpRN2NR?=
 =?utf-8?B?TDkxTU5RK055NHFOVEpNUG1hNG9rTW9EV0pUOFk4VFcwUGRtMDBtaXFHdFBn?=
 =?utf-8?B?dE5Xdys1RmFuY2hSQ1Iya3I2dkF1enRHV1FwUEYxRHNjcEZPY3ZpNzRLNHcw?=
 =?utf-8?B?MzFFcTFMN3B4L1ltclNKSDYrVURQc2duMlppNUZzYnkyRGVoWXVVTE1hQ1BY?=
 =?utf-8?B?OURScXB4TnAvOWJ3dG9pa2NKK3kyNXpzcTlYcFdoQjZscFlnU2gwRDdVR0g3?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F595AD929184C3428DFEB431ED206902@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mPKBKCIuv3i13Anugmy8pi9idI8xp0fnvGc5y3fUhsCsWFLHkg2mLwOuFZrvmMrEfQKXcE5R7kY1NjlnKfL2ijQGJsBZL9NnsdysyTxrpqkEobxxwtD93UDwq31a+5Nqpuhsrj2K2WHatpLexhl63ynwkT0OfEtMvNXN1P8PWGKo9JZtbZJ3AN69dFx3VIDiENWQw4zNRReOVZVzw1RR6cVYOi+F09U2Q0jhR/wumrlsaabTx3CQ5qPA24WlOHTjb1NfcluIaxgLq0Uy7Ergv5s/jIg99GOCMG0wz4F+mRiFB2hZM8kwGYRyax6cZMORWEeLmvIvFTT+J7q0HpyC+sMo0soNVmHaX9tcUbrDlIsapz0p+DHY9mVDytlRbCAApQCk8eY0Yx/t71xioaXRgkKsuEvwAOlzlKqbggIGI6iiOmGoD1IKvZy9lwID7seOjbVnleJS/aGhexUi25/EMcfAyrSixOO1Zj9ExukKa8jhYuwjWj/zNvLO4Kx4gdAJPhpJmzayczvnqJHACAwQI7oI1Cf/cPqKI29qZfAMoZYl0DixrJteMrwEYGg3SONtrxgDr0xk8/wZZ66wPX1H+ZCKyXkN0eswHVCF+GOPF3+vnxqlyWtZOVrZacr7Iq/TnNLLOMuS7fxnKfRDWT5tSHQhg+9pbLXTIlj2kLAvcgGjoifpsDfMq13LymIgBirTx5xW2pMbQ134lZ97rHjMZwiks9z/j2kQe1DdjyT6+mfCZPH6ZNwO3Yx8wuBjVRmH6xa16LslUy4q9vlDMDQ5KP3CjfYRiX0FgrWnndjmu+Y3MDkDXQMtFQ7hOyfNXKkz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7842fb7e-b879-41b5-f130-08dbe46446fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 16:19:14.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrQLXiVmCdfuwRCgNj39hbmPPfq0aQpS+lrCvJlXET1QisFijK7groBrGmiWIRMuNM3mFq8Pfq/CHA5k0FovNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_06,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130133
X-Proofpoint-GUID: 2ebyWEawr5zqQokSqyMD5vLvTagcmBOm
X-Proofpoint-ORIG-GUID: 2ebyWEawr5zqQokSqyMD5vLvTagcmBOm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDEwLCAyMDIzLCBhdCAyOjU04oCvQU0sIE1hcnRpbiBXZWdlIDxtYXJ0aW4u
bC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE5vdiAxLCAyMDIzIGF0IDM6
NDLigK9QTSBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToN
Cj4+IA0KPj4gT24gMSBOb3YgMjAyMywgYXQgNTowNiwgTWFydGluIFdlZ2Ugd3JvdGU6DQo+PiAN
Cj4+PiBHb29kIG1vcm5pbmchDQo+Pj4gDQo+Pj4gV2UgaGF2ZSBxdWVzdGlvbnMgYWJvdXQgTkZT
djQgcmVmZXJyYWxzOg0KPj4+IDEuIElzIHRoZXJlIGEgd2F5IHRvIHRlc3QgdGhlbSBpbiBEZWJp
YW4gTGludXg/DQo+Pj4gDQo+Pj4gMi4gSG93IGRvZXMgYSBmc19sb2NhdGlvbnMgYXR0cmlidXRl
IGxvb2sgbGlrZSB3aGVuIGEgbm9uc3RhbmRhcmQgcG9ydA0KPj4+IGxpa2UgNjY2NiBpcyB1c2Vk
Pw0KPj4+IFJGQzU2NjEgc2F5cyB0aGlzOg0KPj4+IA0KPj4+ICogaHR0cDovL3Rvb2xzLmlldGYu
b3JnL2h0bWwvcmZjNTY2MSNzZWN0aW9uLTExLjkNCj4+PiAqIDExLjkuIFRoZSBBdHRyaWJ1dGUg
ZnNfbG9jYXRpb25zDQo+Pj4gKiBBbiBlbnRyeSBpbiB0aGUgc2VydmVyIGFycmF5IGlzIGEgVVRG
LTggc3RyaW5nIGFuZCByZXByZXNlbnRzIG9uZSBvZiBhDQo+Pj4gKiB0cmFkaXRpb25hbCBETlMg
aG9zdCBuYW1lLCBJUHY0IGFkZHJlc3MsIElQdjYgYWRkcmVzcywgb3IgYSB6ZXJvLWxlbmd0aA0K
Pj4+ICogc3RyaW5nLiAgQW4gSVB2NCBvciBJUHY2IGFkZHJlc3MgaXMgcmVwcmVzZW50ZWQgYXMg
YSB1bml2ZXJzYWwgYWRkcmVzcw0KPj4+ICogKHNlZSBTZWN0aW9uIDMuMy45IGFuZCBbMTVdKSwg
bWludXMgdGhlIG5ldGlkLCBhbmQgZWl0aGVyIHdpdGggb3Igd2l0aG91dA0KPj4+ICogdGhlIHRy
YWlsaW5nICIucDEucDIiIHN1ZmZpeCB0aGF0IHJlcHJlc2VudHMgdGhlIHBvcnQgbnVtYmVyLiAg
SWYgdGhlDQo+Pj4gKiBzdWZmaXggaXMgb21pdHRlZCwgdGhlbiB0aGUgZGVmYXVsdCBwb3J0LCAy
MDQ5LCBTSE9VTEQgYmUgYXNzdW1lZC4gIEENCj4+PiAqIHplcm8tbGVuZ3RoIHN0cmluZyBTSE9V
TEQgYmUgdXNlZCB0byBpbmRpY2F0ZSB0aGUgY3VycmVudCBhZGRyZXNzIGJlaW5nDQo+Pj4gKiB1
c2VkIGZvciB0aGUgUlBDIGNhbGwuDQo+Pj4gDQo+Pj4gRG9lcyBhbnlvbmUgaGF2ZSBhbiBleGFt
cGxlIG9mIGhvdyB0aGUgY29udGVudCBvZiBmc19sb2NhdGlvbnMgc2hvdWxkDQo+Pj4gbG9vayBs
aWtlIHdpdGggYSBjdXN0b20gcG9ydCBudW1iZXI/DQo+PiANCj4+IElmIHlvdSBrZWVwIGZvbGxv
d2luZyB0aGUgcmVmZXJlbmNlcywgeW91IGVuZCB1cCB3aXRoIHRoZSBleGFtcGxlIGluDQo+PiBy
ZmM1NjY1LCB3aGljaCBnaXZlcyBhbiBleGFtcGxlIGZvciBJUHY0Og0KPj4gDQo+PiBodHRwczov
L2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzU2NjUjc2VjdGlvbi01LjIuMy4zDQo+
IA0KPiBTbyBqdXN0IDxhZGRyZXNzPi48dXBwZXItYnl0ZS1vZi1wb3J0LW51bWJlcj4uPGxvd2Vy
LWJ5dGUtb2YtcG9ydC1udW1iZXI+Pw0KDQo+IEhvdyBjYW4gSSB0ZXN0IHRoYXQgd2l0aCB0aGUg
cmVmZXI9IG9wdGlvbiBpbiAvZXRjL2V4cG9ydHM/IG5mc3JlZg0KPiBkb2VzIG5vdCBzZWVtIHRv
IGhhdmUgYSBwb3J0cyBvcHRpb24uLi4NCg0KTmVpdGhlciByZWZlcj0gbm9yIG5mc3JlZiBzdXBw
b3J0IGFsdGVybmF0ZSBwb3J0cyBmb3IgZXhhY3RseSB0aGUNCnNhbWUgcmVhc29uOiBUaGUgbW91
bnRkIHVwY2FsbC9kb3duY2FsbCwgd2hpY2ggaXMgaG93IHRoZSBrZXJuZWwNCmxlYXJucyBvZiBy
ZWZlcnJhbCB0YXJnZXQgbG9jYXRpb25zLCBuZWVkcyB0byBiZSBmaXhlZCBmaXJzdC4gVGhlbg0K
c3VwcG9ydCBmb3IgYWx0ZXJuYXRlIHBvcnRzIGNhbiBiZSBpbXBsZW1lbnRlZCBpbiBib3RoIHJl
ZmVyPSBhbmQNCm5mc3JlZi4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
