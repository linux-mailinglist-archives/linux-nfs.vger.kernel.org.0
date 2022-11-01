Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0126D614C25
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKAN6Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKAN6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 09:58:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5787191
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 06:58:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1CObFp009950;
        Tue, 1 Nov 2022 13:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Nb6ef9kJR+MgKgHodwCZCQtrr+HjMbh7DP6Vi1fih5M=;
 b=ML4HI+I0EoqhnSJsiqA6cpSJFfS5ZSgonktyJtS7GVsVbIX4UnvtZGtBLpRDGu6s3s2q
 RwdmIgWee+BZRSC46iPFoZwjYgKkQ3pkOtgsN9VTe/dOlPoCpDojt5/avQIWdcyK3DKq
 U4fOJPsK4nGZbX9wcjU6Hze2KL/6nwLecN+oLhsBmnj0rOqBgOGebv6goJHS5p+5Nie5
 Q7UzQPIMhDBmMTBKtSoi7TBJCdtCqqfyy1skbPqZj46Lq8fKVpK3ovmBa9qu/s8ty8td
 dE5qYgrktIQYDZ87ZT5Jrfl48dQviVdoKOwo4r4m/kzNPgzYBYT0IFmgXo45pX/+mwbI Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtepkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 13:58:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1CTUNc025902;
        Tue, 1 Nov 2022 13:58:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmar2qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 13:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M75n9eJ9ayWGVPP1D3136W3vnymGwyw8eyFI7Wsxf9eKjluqdpLh3MPLfKUVhXnex+mz7jnpdWpLKtKPQJwqYRiLLfdqg4avSAuzbGgOHd29eAyPHcQsomXHvf4GmcnL7ymqAvYMpZJqDswTTDrNEYJqEmp/NQjytkcIZHwFi1Scy6haMt/m7zcD01u7BlHwLtI01ihHrqPvsfVGSiKHRlPzzawGUXhN5Js7FK+SPzcKspsMvtw+JgfQgC/0brtIxoyFHzmseR/Ea2CLgtFlvcSH21DgtXXqilmd8C29fClM9n/A9jAjiYQToThf1+E7m0zhzJ7PtWytYr1LvhQ17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb6ef9kJR+MgKgHodwCZCQtrr+HjMbh7DP6Vi1fih5M=;
 b=Vi1Pcm2dwTscl7gch1i9gVOQYja7/azWTBpEyOxc85VvRIca6PKnZrYT5vMRtiyIczTvv55m2qkrXeTH30JUNYCk0p9Es1XeaD7JNifC77lj58OOVJQW4Anl7cZ1mNPcH/xDk/S2kFCEjLmxT/yDTXGRiN621D445x7a9NfsnThafG1EvswbjBStta7xNvghNcHNAt6ksq+6BleRQw/tWP5StyfoJXAwQ3q7fna9wnu4Z8RLJWOklpnJf3z5LEZ2gnxp1nnhr2X59GjLr80qd3MsHGfLLNQ1sVwygIyIeKu/LBrVPVajD5ujH7oGU8DlYeKsMSy87tm+1mrPYjBQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb6ef9kJR+MgKgHodwCZCQtrr+HjMbh7DP6Vi1fih5M=;
 b=XVpTQfpy+N3A2XTOZEp5B9qH9F3IdHmneSnnMTOBTnoJMng9MmHrOYqDn7AmW1zNmCmM241tmLiMYcLEVPo+cgZKxjp42kolmfGTQpwU+BZgS2KiRom+zE8uVDZL66+P3xLxCmRq8CBwNb4T0qtYpL8pbybCsfo4T8ysRDlqB1c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 13:58:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 13:58:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v3 2/4] nfsd: rework refcounting in filecache
Thread-Index: AQHY6v8c+/AX0w4PQ0iPSe2aFwWbQK4kNtsAgAAGgQCABeCZAA==
Date:   Tue, 1 Nov 2022 13:58:11 +0000
Message-ID: <494CEF8A-E9AD-400B-92E6-EEE3B2DB431D@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-3-jlayton@kernel.org>
 <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
 <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
In-Reply-To: <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6257:EE_
x-ms-office365-filtering-correlation-id: dc60016a-f15e-4c20-af41-08dabc111cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OoicHmG2ZGHudJKAQeROVpv6TECgDiW16sunUrI1Op3760xlRp/qSUWEemWKhGo5wkodky9ye7kX2a6+aNt3lIg8D0KUBnQ+khXEH+waEZg+vp4byDMb60R3+E1iNDpoPFoEmEWQe8RDG2V93CiPLQhH1AN32R8XPvxEi71sImBAmAdJ07JwiEoemFe0RK1SRLe4vxEtQqi2IsRF7M0xA9iqiuykmWF+m4u/ZihLEZBjlMQB6rNhwrBY+U5WTXPmdP/pgwo2+qxOb7XPQr5qofZPzHmnJsLf3uIOHERgNxNehyPVZLH+xDF75oZR7DWzq3a9r/UMaKltlW3KJXCDbKi4QX9KwXcYAToWw+16AfQoCIs7c3TLo5mXeyafXx9D1b6GvupSA3TdzRyaoSJmon5MoA/zMkW1Sa6tL75cfLHxd4gjG9Hg23x5w8Bo7WAOigBKIdISXPhrlTqCT2VnuBqAXtqF0E5i1tUBUE2Oq2JIpp0hGc3mVIgQKneehAe8LM9+clwnHyVppB/XidzGxM6Y7soRaLP7yzQ7/WB2mtgGdxyR9Q6eWnuzv6iJi5qsqbem5CMnma1VX/DBVO3Pvq8FpE6YA7mE6xZkF/+2gno8q/fIo3wxtFqZAspsgyMz8ZaeoaAMh5IXWchapFZpekNTrz9kcUvdcRl3wxybyQjCwZB3V9AO32dIdBlkHv7QwPyDNY9BPDb6CuGf3iSA+qSUIULdAMM9OrQu41myQzOB5qi0fFr8wKEqKnCgaDhPivy+some4bfMz2HVR/Mh+hoRnumxc7DlBmFtC1ZWZPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(2906002)(6486002)(71200400001)(8676002)(66946007)(91956017)(4326008)(76116006)(33656002)(66556008)(86362001)(6916009)(54906003)(316002)(83380400001)(2616005)(36756003)(186003)(41300700001)(6512007)(66476007)(5660300002)(64756008)(6506007)(478600001)(66446008)(8936002)(53546011)(66899015)(26005)(38070700005)(4001150100001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uc5qW64KA3YILAn5Oj3/EfeULi3X/oTSkYLgwDll81lOu98euE5W0mtIKJyF?=
 =?us-ascii?Q?0MTmceho+S+t2RNexMq/cbVMS2ujK+25/Hb/HSZ+covf0VUn1RJUDGL8Y8iN?=
 =?us-ascii?Q?DTxEZSuL+sq6PUHM/28BEwfgoherpL8kSPvcJB4xcnE5XbioszlCUtcqYOYR?=
 =?us-ascii?Q?Tjcjw5sFYsNxVPBuS2Iym5vlgU3c2iWlp5k7eoMaTYIEPKWLA0u2liAsZXKa?=
 =?us-ascii?Q?FxgkLdOAKMjIEVpfFK/9Xk6ob/gNSpiWUSu/RFbbJfPIuQtB+X+K3qZOMS7E?=
 =?us-ascii?Q?6hxhxmZrHRqvAane8IxGfsUahJ2x8Uo40wg9RHtUkw1Tfa0uIDLctxH3fbYa?=
 =?us-ascii?Q?b63gQ1i+BH9GiqtuMs27krzFehBqF0PrtRzRAQJh6u+sJ2vmy6Chf1cnkk7/?=
 =?us-ascii?Q?rMLD8Z3Ew35sKOz4A9PYljHz8BEdUlzmF3g00oXlm44AkQ8CNw3Yyi2tgX+q?=
 =?us-ascii?Q?am/HgPlkMRv/qaHDzPljEcSMv6zebvPrA14FEUVOXRrH9Q3zl/9QSrHtJzs3?=
 =?us-ascii?Q?V/PlWmWstBKpADFQXHZ9pj7KYjBApAx1igvV6jBglQW6F4l3d9vK2ZeyZHCV?=
 =?us-ascii?Q?tXB+At6xIJ0clemTrqH6jUETR8Gvvh0zBWeN/848s6Ee4iR26JNds8gonWiy?=
 =?us-ascii?Q?MGamfB6QvBNDWG97nBH+jSFYStXzAFMK0uCSf3SbYp32J3ytLEm+SllZpoO5?=
 =?us-ascii?Q?SKsEbfKnpxkkmL8IxTs1zGKic8jiEbwVuQzYujM0r6tWUN3WE/j8LuLQmNGd?=
 =?us-ascii?Q?0sMO+PsfUapLe49V4dBPLHzR6N/Ys5GIi1gXnpS9NaHMU3yWc2NQSgRXL92z?=
 =?us-ascii?Q?5ky6SEU0dWOrdndvLhyNuiehSdZWxdx5hO2MTzXjgUcWaXUpRKgIV/K9lV0b?=
 =?us-ascii?Q?vwiSGfg0Oh3iMITNgX5xSw4B/V2DQpbr+aFQSlI3+njFLPM4RM9C3OBk6jsq?=
 =?us-ascii?Q?I8zyV+iB7KeTtRfvvqNuU1w5iZGRTeF50PW25Fc44TOnR/YkAwFnx/FhNFZ+?=
 =?us-ascii?Q?TM/KMAr8/Gn+YSCzQtN86r16tkYB/jO/CDnKYBsdSxIekHjeLsUALaLvX9PZ?=
 =?us-ascii?Q?iLLdGy8PkdQTtzyRxFvnAg2RN+GbW0DEcFVkH0Q0M7JyuehrapsdJzjXv0ZF?=
 =?us-ascii?Q?RWQ86L8J55SZsZ6YNFLHxwUx+zR0zPukIuuEDcuXGIKZJf/Z/VVazLfWTR5v?=
 =?us-ascii?Q?bzmrRjsbPa7xkwWWLvKmwLdtVSsn05r4l+xuZ/Si1z7e/OU5gSoTLzFgodAw?=
 =?us-ascii?Q?wMUUlu/BBGBFefGvCV6sK/jOIKLvqFxCioPe1QEnHy9P7UsahrDEMz2o/+3I?=
 =?us-ascii?Q?jRWdos23IKFwFxgsMbIncjz+TCdd0MD9v2QX28vx9opD+NEU99fsB9C1HWXi?=
 =?us-ascii?Q?KCWZVTDQIJuMZH6vqrZlMm1RoMpqrnaLDFyRIm530PmRWrVpFAHxjp2Pkfz5?=
 =?us-ascii?Q?fKvAOxKbV1DbO0xImYwhO+na/iPWrgGdIGJwEF6C/oaCpHsFj1LmnaUum6t3?=
 =?us-ascii?Q?hh7l9Zlqob/3FMszqHWTZ1QkUoC+mTn2lyWTJOCMDA0fgTJUaI5yqY98PS6c?=
 =?us-ascii?Q?c5r3M+2M4DhfTLrA5e82dl7ap4i7VlvNsEBxcvdd9BktcGWqGufDTcg3MHHq?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEB5A1C086CB0D4B889F029EB148BC16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc60016a-f15e-4c20-af41-08dabc111cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 13:58:11.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPhcOl4iB8fdL8a6A0HYhp/0+a6ffJiYJYAkIm11TxuRq0B0q6gFWCcTeHoVn5puqxWSDmKEnPLVBDxbwaC2OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=892
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010106
X-Proofpoint-GUID: gKinAiQDlE3bkxIHB6sBaku52eTpA-fc
X-Proofpoint-ORIG-GUID: gKinAiQDlE3bkxIHB6sBaku52eTpA-fc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 4:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 19:49 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
>> I'm still not sold on the idea of a synchronous flush in nfsd_file_free(=
).
>=20
> I think that we need to call this there to ensure that writeback errors
> are handled. I worry that if try to do this piecemeal, we could end up
> missing errors when they fall off the LRU.
>=20
>> That feels like a deadlock waiting to happen and quite difficult to
>> reproduce because I/O there is rarely needed. It could help to put a
>> might_sleep() in nfsd_file_fsync(), at least, but I would prefer not to
>> drive I/O in that path at all.
>=20
> I don't quite grok the potential for a deadlock here. nfsd_file_free
> already has to deal with blocking activities due to it effective doing a
> close(). This is just another one. That's why nfsd_file_put has a
> might_sleep in it (to warn its callers).
>=20
> What's the deadlock scenario you envision?

I never answered this question.

I'll say up front that I believe this problem exists in the current code
base, so what follows is meant to document an existing issue rather than
a problem with this patch series.

The filecache sets up a shrinker callback. This callback uses the same
or similar code paths as the filecache garbage collector.

Dai has found that trying to fsync inside a shrinker callback will
lead to deadlocks on some filesystems (notably I believe he was testing
btrfs at the time).

To address this, the filecache shrinker callback could avoid evicting
nfsd_file items that are open for write.


--
Chuck Lever



