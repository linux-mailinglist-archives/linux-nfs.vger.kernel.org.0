Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB7D37D0D0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhELRm4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 13:42:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhELQxx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 May 2021 12:53:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CGp2Lj086192;
        Wed, 12 May 2021 16:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RFypHLUsJhosOM7tpooMlQgYfpuJACH+DRioBJMRUEc=;
 b=IUbHWrKd+8448W2MTTu0clAkD2UVxFTPYgpPsWbrx5mQNfkmTy1Vb+HFIzVm2ZxhHNT2
 irny7EzoImPN1qFa9bgusPBOqgvjdhsh8afjw4t66XqdBPIDjk0Z4tndPFg3v4/2Pxv4
 IppA5Lcl9K+arOjE4qh8uFEA3XdeFiZpZjSXBOe8AIOo0R+GTDvWy+AnCN7hXWIijUS/
 pUu1PaIpvgPEbF5KZnyjX3wVw7goRpbfmzb63FV6G/slL2xyfdL31a1ufMiXNhvPh7TU
 fzkSZOT3XvrAMPYzrrxAfizpDWX6NRpXAOd8E/udE+0nnOluNo1ZRrFDxxmusOaMMmq+ bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38e285hxqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 16:52:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CGjdIY109166;
        Wed, 12 May 2021 16:52:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 38dfs00y94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 16:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCI08lgmbb3sYRTntRI+nPNn294VPp1ljOxhpu7DIvHIy4qA/KfJVMRVxd26A8UzP/z8RH7Xbtgqgg5mxLI6ufUe4826JHyLaZ8XcqQGrme5afbidD20VqdAeDrn8iOaDzYgjS3yeACqS3NJ1KqXgHX0AqUFRfQY0cwyfIIboM305zy3b8jF9SeXRUif35yqa2GQ5nk3l9r9GK1B9jwaeQGKZXkTyO5krGOxAJVRmA1Yp9JkyaOFxAMstzS9N/pySOX3NIMOcXwpb2jnj8ihF0drn7d5La8CEbZr4Tm8V/mIED8alErQWuHlQnw/IQGpbMOEfm3kZDn2zOfeGFXgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFypHLUsJhosOM7tpooMlQgYfpuJACH+DRioBJMRUEc=;
 b=ClrhhsY7WxZJ0NnKflJnrAAf/zjrgxyS3lTV2AmdcORBVWckV15ECG3VEFAowY+d91notkEvpnjUQOVcxB6sDO7gQQsQjtQFuqWfbSV8esp31r1BmE7wE0mqAH46JDNvy4IcEMHdUxPFJw84UP/zYdwuMKgSR0Rv50SKMblSHNW69qZ3+y+5RQBCS9qlKAVfJb6N+Jj+iTkLc8oJaF6vAgTo7bsJcP3tzZHbFposO3gFOeU3XL8Jd4p+movAM3I3VGR7NqkjwTphGnwRJiWJm5zH4Zmafq2oPpU0SPXn428IJ/pnsd0VfZaKK94jkGw2PYfukhl6nmswNo52j8dHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFypHLUsJhosOM7tpooMlQgYfpuJACH+DRioBJMRUEc=;
 b=nd495hYEv8gQhmpzmwDfQX7gIbW2q/2EiAoAfD+R3aPJFgmJxEdTCd7VFPMws7gYD6Q3JyofLI5rtxFcNsnpMYohFnQ6xes3ATHH1gnYTQEM3Bh5az6NE1T2ouTMshx50a4Kt9PADcRioqvihSAxVUaT0dEbgVuT6DJ88mQ8V1Y=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 16:52:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Wed, 12 May 2021
 16:52:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Topic: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
Thread-Index: AQHXR0uQjwrq7dbjxka4bUuLuYA4jKrgD64A
Date:   Wed, 12 May 2021 16:52:05 +0000
Message-ID: <238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
 <20210512122623.79ee0dda@gandalf.local.home>
In-Reply-To: <20210512122623.79ee0dda@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5440b06a-e24d-471d-2c16-08d91566467b
x-ms-traffictypediagnostic: BY5PR10MB4385:
x-microsoft-antispam-prvs: <BY5PR10MB4385206F51EFE47DF9D4174A93529@BY5PR10MB4385.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1o7tYy6DiKAXXwvmKbOUntuFoDu+CRVUz9ABDi3yjWZYYgJv4QkQScSSS0w98qTF2IFiSKmBkVxMtcsCAKdI8xTevtngotHgQipSCuGG5PQCn63Ulf0ag/Cw40HxiYouNU0HwQW5BwuRRceMAMJAXlKYCqMTEuP+P+HOlO7RM7aRNJgrc02OXqBN+KK3Dmcb7bg78Jf/DKE5ci0tNA1zJ6iXEykiQcUMNzbBqUUI0jUwQPDMo+1LxOgh9e0FTkN8rdWtSH8wvZXcc4NQAnN6qMdS9D51xUWNBAWP8dpBMbnw2E5Z2EXmKk8tY1Yabbdb91jksxsLsmTkqB33jbLO4Wgg7Svy4aKxc9+pnDMP0MlazB6tvdwu+KH8y+D49ZN4kmOcSQzWupxPDz83HDiJLvDKKPOFdV9hoLA8kT6g70FjaBLud1nGmFZEjsQnDdin2fFTjD8bQfotbpS+ScdjKPOt1wCLD9+QoJmZfmrdTOjgf9aEvPqb7RduFKuCwmvsKL1TdGPVSge4KdDjBmSS+QdIGJt1163ujv80A0m5MAz96Tq4OTyddMdpH3emoUfqJh4k0BPX8mkqzoURxhaEKNAMe4ulBRermFhMFvwkc1XmnBLr3B4S/0795G1l7JP0ghr/Ei+v9UzLMIbcMEpT1hAQsLJDUpfYXHUslDBCcFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(71200400001)(76116006)(91956017)(2906002)(186003)(6916009)(86362001)(6512007)(36756003)(478600001)(66946007)(66476007)(66556008)(66446008)(4326008)(122000001)(64756008)(2616005)(5660300002)(4744005)(6486002)(6506007)(53546011)(26005)(8936002)(38100700002)(54906003)(316002)(33656002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NjIn97qRYuaMvJujGethxXxh4+kolJ7S/+b4eBeByGlR0QhhgVb6Rcr0vc7/?=
 =?us-ascii?Q?h3USHOV3+UUFCDtDBaMdzHbpEeahTcSBtde5mIYEAOeEXiJOAoeUH8PtXJay?=
 =?us-ascii?Q?16sDNWGe+M5sRsMMyjn8wlSOye38maUiRZ4KUomGBY0TAhakaN83hHuvLiuk?=
 =?us-ascii?Q?7qRGOuUofRVTx9KdpU8xJyX4xNMw+1MS7YsPBwz3KvSyY+sKQOzZt3tOy06v?=
 =?us-ascii?Q?/37JVmmtGpuDpNu7xarbFFLOdeOG4vyhQJfXsSlLuhAwGMui/fBUtFiDb2As?=
 =?us-ascii?Q?iiZ1IRw5fPubumrRHDvWqMY8n54A2zbBrPjLpxkOBM66Gj18sddDHENgYiKp?=
 =?us-ascii?Q?YD2vNlSD4nit6/bbI5KXbXVdzJED7IoB+WYXEM7STFOWc3xldLlty32uCXJC?=
 =?us-ascii?Q?C+u86upPNHRSpxVnmnnUMVRGAW/iQCcq8m2HLOklFvnOq69o3yVQ9OfX5G+A?=
 =?us-ascii?Q?p6BdN1ntDY8Yx2ydNncWblRO4/UtC6AcofXtb2RndOgJgzseCbhRjOcgSED7?=
 =?us-ascii?Q?lQoY/b/EqasQOgn5YVyWoccItjASQjo1BCpcQgyZ1gGzlhZGBRtzxxPMMHEy?=
 =?us-ascii?Q?2dTjZG0O0zYTpSpYK820/sB8Flftd1gOOuPV0YOa/PvWVMVkrkjl7kHmnzwR?=
 =?us-ascii?Q?gbN0KWaYhsk0zeLPBZASjgb78pvAx/TQk3l6K5Wf/S3LUQSfxLnLs+B4ivXl?=
 =?us-ascii?Q?V7BCSpk6oXc8wtN0dn+haPeQlNCS/u99AROlSdW+ofxNHUNTTklT/aao2310?=
 =?us-ascii?Q?Ysk++BQ9df7FEwgKZ0uadIn2CaeglWNbhqD4bhcXZNSenBl2B5xUJU+ujHsc?=
 =?us-ascii?Q?4nP1VaYpNvxw39mNal6DX9ohUSbDDvlf/oOpzOtG8awDqk1h5zz9GjWUCY/u?=
 =?us-ascii?Q?TUMkpkQJ7yIj29jJ46ysZ2C4BoGs5mvbxIDijQA1bdwwgHHH552WPBis1Mb0?=
 =?us-ascii?Q?7jDF8LP5tY1FF/bswieB+NJex6ONRy384f+a72ZtrfuQ0reA03zSf1Y/2k2G?=
 =?us-ascii?Q?OQ5CGVi/OXlHkBEOTiI+FejzJ60xN9T4vC3FrleIhbMyktMtCqLpGfqTCrVA?=
 =?us-ascii?Q?fTp0Le1eo3Vbf/5RTI+q0KVZJ67mcbcre1d9TcwUCLEFAtfsQM4VTohFSTsW?=
 =?us-ascii?Q?l1vTLHN1HPWpwVXiZNliC6dQPU1fRO2oVpAfBTyC5enrvYt/pgz2jkMmum1Z?=
 =?us-ascii?Q?aQn+BIfX1TCdDQaWesGNNrMNJvBa57bA/hTAw5yViUL8j/+AcVZXND3SvIko?=
 =?us-ascii?Q?BNGecAYZssP46l1JYt3i6wjoVQNEJKWtfMf8Db1hSK/6IsTbEVXlVWrfg+FB?=
 =?us-ascii?Q?c1LxIWjbAo47PCN11uhP7IYz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BB920DF0664824B801AAB4DCFAD5197@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5440b06a-e24d-471d-2c16-08d91566467b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 16:52:06.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jue22Fv8mFPj9oPyeU8qo0whqhNTp1NLXEvxTfpn3t82AMhUzV+r9Py1hu59YikNPCdXUPgeQ36lKebyZaqkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120107
X-Proofpoint-GUID: zE5db5RW9E2Dl-Vg7UT_6j_y2u0dfhek
X-Proofpoint-ORIG-GUID: zE5db5RW9E2Dl-Vg7UT_6j_y2u0dfhek
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120107
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve-

> On May 12, 2021, at 12:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Wed, 12 May 2021 11:35:02 -0400
> Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
>> Since commit 9a6944fee68e ("tracing: Add a verifier to check string
>> pointers for trace events"), which was merged in v5.13-rc1,
>> TP_printk() no longer tacitly supports the "%.*s" format specifier.
>=20
> Hmm, this looks like a bug. I should allow the %.*s notation.
>=20
> I probably should fix that.

The underlying need is to support non-NUL-terminated C strings.

I assumed that since the commentary around 9a6944fee68e claims
the proper way to trace C strings is to use __string and friends,
and those do not support non-NUL-terminated strings, that such
strings are really not first-class citizens. Thus I concluded
that my use of '%.*s' was incorrect.

Having some __string-style helpers that can deal with such
strings would be valuable.


--
Chuck Lever



