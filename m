Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C26F9E97
	for <lists+linux-nfs@lfdr.de>; Mon,  8 May 2023 06:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEHEKa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 May 2023 00:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEHEK2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 May 2023 00:10:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181586EB5
        for <linux-nfs@vger.kernel.org>; Sun,  7 May 2023 21:10:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 347Ll2WO009837;
        Mon, 8 May 2023 04:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ng5ZyBUuluLisM9qs4KHB44Pyl+DdvlULYcceiossXk=;
 b=eQHR3TSyRxBl/8trMuqM9Lr7r6j50H4M/3F3cxPuj9uzWJnzMcXkBi+yHS/SJCIB1zWe
 gPpTlAQErbnNjACNNrVj9m26glOGGBDszcB8oC007isN5lNPUBeDBQQejB3l3Jq6hDDy
 UjqSrB3yIFQhIXryhAtf6uT200flanRoH4uWZRkgLkZARtpC10Yh5znNzkE8SkYP/Ecm
 kvSvfaJnZakuJy4w8lkiZ4b/W8Sg/4AwICsc40CpleYO8g8dJ4h8lbkTDdXNuBc2sNzQ
 KTdbNlX+35q+rgYsFqx+w4LtsK08VL1LYVoaNgaixrkx97IkpMZYuubwJ1wZoNGGKxWd 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qdfev2a7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 04:10:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3483tuon013964;
        Mon, 8 May 2023 04:10:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb45xxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 04:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPatfXkM1nTWOuERPrCm2/3gamOFTczsd4KNw8RY1rQgM+zqKLGZNkriBx4/fSid4JLXEcGF735OziyIY9f9telzYyH77wcjWnJSeN2vQW+9ggDlNE1UfHyimaZnEcWlnWvqAVw5EI16W664t+knZbSvsFVbCHdG96Y0vqo3R7kJmeCEM+OgqSEJ6+gvTxrllNeWDIA1dH17vMUFH+UwBOevMcFycPwNs2Q26X/p1I3EYCxUFpIqVYC6jeW1YxP1CIpqWTgIQrm6MtOMrJQu14AB8IJNIKGCmSNyMdFqWRO8AJmEp75yrIbgxjaEH2+N6ib3/a0uoCKRdb5+l6KFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng5ZyBUuluLisM9qs4KHB44Pyl+DdvlULYcceiossXk=;
 b=X4gE2iN5FhA9iacEAYZW8XaLCYmgvKkdyvLKZC6PPMQC9lMlZAhf1gsjiB0GfAZdl6e68YUT6HYgSbE1nA+jZhGLTU1pMVp7Z7igUZ0g5B5390n6wfrA8GFm6xiWFtAdAnxOCFO/J2pK4XyOZL1hIhR/tfRF9Gb9e4/O1c4VyGEAKPNAszY9fVapn/OrWDWxf8XiS2+bQuOdDTQU9qSn+DWPSyUoQKKnmx77CtOxp/Kzbq1ufIQGGbwYphL0DYSp2GbUJQA+eGHY2viUYzak6oE6UY1zKhuS663c8DIZ+a13BWg61zuY1539nffavz+6C75FJQusS7Tq6FjqCLpTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng5ZyBUuluLisM9qs4KHB44Pyl+DdvlULYcceiossXk=;
 b=H6x/FXnD71xHugzH/EU+5hDSTRcSFG3i8I8jh6+sPd1xZFIky0du6rbGkfbeIXhyDN0uVQQngvGtpN1DQnsVxNp4888X9+S1S0zeOqygDmZUbX0gwNsAFNp3Rc/EUMc2DL398s9X/OHzxDMOKfFoMUkoV8aeIU3D6r+nkYq2S40=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7392.namprd10.prod.outlook.com (2603:10b6:8:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Mon, 8 May
 2023 04:10:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 04:10:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/2] SUNRPC: Fix NFSD's request deferral on RDMA
 transports
Thread-Topic: [PATCH v3 1/2] SUNRPC: Fix NFSD's request deferral on RDMA
 transports
Thread-Index: AQHYSqcDgdkMHb9iMUaKszk/zy6+869R8HcAgABAKoA=
Date:   Mon, 8 May 2023 04:10:16 +0000
Message-ID: <4CC536D3-10A2-46EB-B12D-231CED2EBBA5@oracle.com>
References: <164935330144.76813.17862521591948764594.stgit@klimt.1015granger.net>
 <164935340273.76813.7096678268046264254.stgit@klimt.1015granger.net>
 <168350522604.9647.16917749332832150697@noble.neil.brown.name>
In-Reply-To: <168350522604.9647.16917749332832150697@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB7392:EE_
x-ms-office365-filtering-correlation-id: 0cef06d1-d005-4597-155f-08db4f7a2120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7t/NpP4VCqQYjdn2g8Mj6Matfvdfzx+GUhh03VsotB9CNpTpcc3qrdBYF4nZSLcqyL/O7uheO0Vb18SMSaal0xYfUwLgvp8/ne94BN7FYfbeR+mP3G5B+hYIN6Hqxh4cBQdZe1sBg1RDKjwbZ53gEjhv4iqC9CEw/IVBVI+KHsWvrj8OMlpAvqGHFGKiTChH8Q99fKWPsECWfJKhF432o+765X/Y1Dy6PDzs25GSos2CTbPm3Qv/lERQQBQeMlkfm4kE1DR/zel7a1IFE/o6zGPjlQc3dyQme6VZ/z3mHPdOs+GniYC2ngkL+LE4iDuGK+ljph7twuD8Bj+dKBIz5Ll08/NOBD+hesnIeOO9/tPulStH9ME9jLcOOjgwZhGacjXrMGpUt96izEYV+mcwFRpfPVuuKon4yUfgIgxELC6BOxF4RiA7pFiExOEzGzctBfyKR+e0nhWrPrfi3XeM8hqpLsmrb3biIL5/5Q2Tz2YBbTFSeNg9SqMWkxD2iLAXQ5dKI77R7cjdpwrHxe2snQ1EvsFHeLf6adN6N+JONlmrNjEpWO7DUuOjAR01esljIh9pqiKR/jmi63GEAsyVKO3Tr9xy82pIwdrvMZkc/cetRewzpkynM/WbWI+hqt+NFVVsA0mJuW/Ucx6SVermg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(2906002)(5660300002)(38070700005)(122000001)(38100700002)(33656002)(36756003)(86362001)(54906003)(6506007)(53546011)(478600001)(186003)(26005)(6512007)(6486002)(966005)(71200400001)(316002)(2616005)(8936002)(64756008)(66556008)(66446008)(8676002)(41300700001)(66476007)(66946007)(4326008)(76116006)(83380400001)(6916009)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzBxiJh4o6YsBTx7H6D0ZL9zP5TkmEuhHkiuitXJaeFbBd2Vu4NjKMt6SJia?=
 =?us-ascii?Q?ABiptIOAmSXO3kKSwI6FDxsySjnEkGa8iULAjrpcG3ZaplYSmCQmMgpyJnaX?=
 =?us-ascii?Q?ZChTRC3zc4AHiDtsIOTkkfhohMVzZ/tft1ZGJJt36uhijZh1+4eqnIBhGuST?=
 =?us-ascii?Q?k1FSwrAKJEeaKmey1ocUO93pkH3k4h72ewyBIBaIFJZ6nz4Ygp1kCfFjwxV/?=
 =?us-ascii?Q?l/8WmlkXFChsHjJV9MCdGDMnFOxBDbeO/bnlC7zFSRe8Kz1t+fV34+mxR6pF?=
 =?us-ascii?Q?OBSKFYM4NYj8hjZ6WT0inQwmlZ0JdYjWKVqrBoCTYMxabidFrQsEPNMz1FbZ?=
 =?us-ascii?Q?xh8tdS/W/SqYWSfcETOdgBqucMzQ1Ri2XRrMoto0WtDaa187SopwKzC55C/q?=
 =?us-ascii?Q?xTD/C22lp+O94XxXfJ7BbB5jNJin/GFAP1oHYBrZ19/x+9bP1IaEqN5qY7VV?=
 =?us-ascii?Q?R6xZ7hN0j7+ERdtZvqR++TvJM4xy6SmOb8dGxyxeQ26y63bkIU/GmQe2MtEQ?=
 =?us-ascii?Q?v9BU3E8ndJgiL5O7chRa22C8JCjcFwv2FFUXkJaOPfKA+tXT8xbqgs2PJ3Uf?=
 =?us-ascii?Q?IvdDT/IkZT4f9jTgh+EQOKuNKp83XkxhEIS2v+JceyAETT2kO9pP0L9S1B8X?=
 =?us-ascii?Q?IJYwavm+nzKnEdDwp9ZTRwe/yVhWH3OiaMnd3IjIB1sMqXtDruxCOMWXzpoB?=
 =?us-ascii?Q?RqLUB1rO6PZFEDUVRyfK/APSYEjIylZg+lwC5kfGfijwplzTdwFjOW+sr4Nl?=
 =?us-ascii?Q?CIzZVh88P+qrpoPZ5PCUbkq46ZBi8V0kohllQBtRxZk98okP9FSxGKWyAGkt?=
 =?us-ascii?Q?NNLpgXBdXMjbfRway9YiB6anpcIhChDqiVF1WCWj+2bZj0R36M4ms32e4P7V?=
 =?us-ascii?Q?eyVCV8R/OmXl/WOCYEuia3H+qnH1Ag/TPlqoyoFc+iPAU0lQEm5H7+7sbflP?=
 =?us-ascii?Q?1af1C56PZoPH3kffWh0PuUtw+GOKW6USOem2y7+5awtx9Enxeb1Ce5jyTNFq?=
 =?us-ascii?Q?lbupltWZx9e/C6qVqufPv/x7Yl9D2cscsTMwxMK7Qjd74Ha6d++SR4a2qH/s?=
 =?us-ascii?Q?3md0VjqGNSMrlBXIKts11DzUNUfRQaf2VTCrCU7+Srw/uPLHHw3/B86gHoy8?=
 =?us-ascii?Q?sshccWwSXd9myamB16fQR4v2wmEYnE0xyU89+sOgr44c0FWpAtIqCp5d6XFQ?=
 =?us-ascii?Q?XoMrByNpZi/p9ldKi5a6TPeDOw2mnsmKF8Zc0Z/GwCIxIRLwSLAj0BUZ+BHO?=
 =?us-ascii?Q?NnVq25IbTp1Dmexp1OarpbR3SF9Ho066fWI9WD6MMoiCNjnu+Obf0o23JujL?=
 =?us-ascii?Q?5297Aj8bltn9yVJvhxS4zieu71tQPNnAhqoSbpD/bVBfBI9hW1z2IZBKM9kN?=
 =?us-ascii?Q?YsxZE6fjkss66wxpWgEa8/1j5wAoxtAzBsLAZkBC7nKktCfs61OnLIVZfNVm?=
 =?us-ascii?Q?eBP13OUg4T+TSVv4C7sjWyxwnForrHP2EpmYTt4C/zPYkDs1qc1Y8w2JupPv?=
 =?us-ascii?Q?Crh3QOtm7Q/pcwiJWBVrdy3pAVrds8wJll2V8kenBMzvMeJE1IsJdyybrNHQ?=
 =?us-ascii?Q?A0tx7MC0JDBHQSf9g1pGpJwJbBSFV8eDg3HrsgdCfK+nE4vbuJfU8NRWQVyV?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4CF8F7D6539C941AC909C580287FC83@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nzFZZmmLtSnERhlXmxak0YmPa3J/m/SASuGhdWm3XvndJMZujeCvzDEkJ1m2wIjhj37UP/TtmuxUnDoUWlfwn6A3BPDfosgQWmGqg+sJhACbKgv3np2Fm0HhALBkUDcHQApYllMfoTzwmUTHBWK1b5cOGiWx3sBd943uFbyc3j528ssMrkfzykNEbPnwxM/0p7pQz/TLzyRQBB1sViwgO0YSDLDZUCkWmgmSDlSb1hckqFQLW7qFQ6V97Dpxji8xQHe51+dUcUvySwf7coRb9l0dDYwcZ9LwqtoU07xzfWGNLqHz8F/qez7pX660XohNwbBO3RebkFM28VAjaodZsDNlgzW9zP8JxHMHcl5uDzSCHUBrgijhRFT0TUSTlcwGCckIK+e/d5tOEpS/ST2mmVxFljE/uqF/JYfLNikQQ4FDjlilKbxm/Wux5VH84550SZXbFpDP3m+W7rLE73rB/CTBWX3rPWuvr7xlQ6++hWnh04qufk+i8dGo9tYwcxNaQ/KdQwSZ7ToP+O/4FqrUZ3dI50w7/tAkRmRAzhaOL4/ALt6x+T9HRPYEvrfIov7e7vS6b6mhhXwONOmrVKOj54OoG14xwPBbtrGy6R5NvjDQK9vW97o3JVfGBnWkJB0AtUySrlQzUeeHYvPCJHGMGyucvPeqZPBOmCDVEBnXiR2P7sejdTghl/k7fBng1+9SNSOYpvkoA8at5jGQvsqWZOh87MabKeuyqUrUkJwmqsk+7Ywcas9elyavNR2s7IfC//6id5p2R+McyVYqI10tHMN3/olU+Wgglf67FWO1ncDV3GTqsfHLurMlMC554MgL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cef06d1-d005-4597-155f-08db4f7a2120
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 04:10:16.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+JqdTDm/awV1++5iaETn7Nzlyq80c4MNw0k6ugeUHWgSO51gvSBuwck7K9vf05fFgfHC9K4FjrUgEsRnVZEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_01,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080027
X-Proofpoint-GUID: Xp3aVvpgAuqp4-CIR2jI5ZZ09zvr34xW
X-Proofpoint-ORIG-GUID: Xp3aVvpgAuqp4-CIR2jI5ZZ09zvr34xW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 7, 2023, at 5:20 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 08 Apr 2022, Chuck Lever wrote:
>> Trond Myklebust reports an NFSD crash in svc_rdma_sendto(). Further
>> investigation shows that the crash occurred while NFSD was handling
>> a deferred request.
>>=20
>> This patch addresses two inter-related issues that prevent request
>> deferral from working correctly for RPC/RDMA requests:
>>=20
>> 1. Prevent the crash by ensuring that the original
>>   svc_rqst::rq_xprt_ctxt value is available when the request is
>>   revisited. Otherwise svc_rdma_sendto() does not have a Receive
>>   context available with which to construct its reply.
>>=20
>> 2. Possibly since before commit 71641d99ce03 ("svcrdma: Properly
>>   compute .len and .buflen for received RPC Calls"),
>>   svc_rdma_recvfrom() did not include the transport header in the
>>   returned xdr_buf. There should have been no need for svc_defer()
>>   and friends to save and restore that header, as of that commit.
>>   This issue is addressed in a backport-friendly way by simply
>>   having svc_rdma_recvfrom() set rq_xprt_hlen to zero
>>   unconditionally, just as svc_tcp_recvfrom() does. This enables
>>   svc_deferred_recv() to correctly reconstruct an RPC message
>>   received via RPC/RDMA.
>=20
> I'm a bit late to this party but .... this patch is bad and I don't know
> how best to fix it.
> It is bad for two reasons.
> 1/ It can leak memory.  When a deferral happens, the context is moved
>   into an svc_deferred_req.  There are a couple of places which assume
>   that an svc_deferred_req can be freed with kfree(), such as
>   svc_delete_xprt() and svc_revisit().  These will now leak the
>   context.  This is the bit that is hard to fix.
>=20
> 2/ It can cause a double-free with UDP (and maybe rdma).
>   When a request is deferred, the ctxt is moved to the dreq.
>   When that request is revisited the ctxt is copied back into the rqst.
>   If the rqst is again deferred then the old dreq is reused and,
>   importantly, the rq_xprt_ctxt is not cleared.  So when the release
>   function is called the ctxt is freed.
>   When the request is revisited a second time that ctxt (now pointing
>   to freed and possibly reused memory) is copied back into the rqst.
>   When the request completes the ctxt is again freed - double free
>   oops.
>=20
> For UDP there is no value in saving the ctxt in the dreq - the content
> of the ctxt, which is an skbuf, has been copied into the dreq.  So maybe
> the UDB ctxt is a very different beast than the rdma ctxt and needs to
> be handled completely differently.
>=20
> We can fix the UDP double-free by always doing
> rqstp->rq_xprt_ctxt =3D NULL;
> whether a new dreq was needed or not.  But that doesn't fix the leaking
> of ctxts and is really just a band-aid.

A double-free is potentially catastrophic, so I would
say this is a reasonable change that can be back-ported
without fuss (while noting that more is needed).

The RDMA recv_ctxt is persistent for the life of the
connection. Releasing one of those just puts it back on
a free list. So, maybe the second free could cause free
list corruption?


> Thoughts?
> Do we need to preserve ALL of the svc_rdma_recv_ctxt for deferred
> requests?  Could we just copy some bits into the dreq (allocate a bit
> more space somehow) so that a simple kfree() is still enough?
> Or do we need a free_ctxt() handler attached to the xprt?

While I take some time to review code and options, did
you know there is a deferral fault injector that might
possibly help you sort through some of this? I doubt I
took the time to try forcing a second deferral of the
same request.


> Thanks,
> NeilBrown
>=20
>=20
>=20
>=20
>>=20
>> Reported-by: Trond Myklebust <trondmy@hammerspace.com>
>> Link: https://lore.kernel.org/linux-nfs/82662b7190f26fb304eb0ab1bb042790=
72439d4e.camel@hammerspace.com/
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> include/linux/sunrpc/svc.h              |    1 +
>> net/sunrpc/svc_xprt.c                   |    3 +++
>> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 +-
>> 3 files changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index a5dda4987e8b..217711fc9cac 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -395,6 +395,7 @@ struct svc_deferred_req {
>> size_t addrlen;
>> struct sockaddr_storage daddr; /* where reply must come from */
>> size_t daddrlen;
>> + void *xprt_ctxt;
>> struct cache_deferred_req handle;
>> size_t xprt_hlen;
>> int argslen;
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 0c117d3bfda8..b42cfffa7395 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -1231,6 +1231,8 @@ static struct cache_deferred_req *svc_defer(struct=
 cache_req *req)
>> dr->daddr =3D rqstp->rq_daddr;
>> dr->argslen =3D rqstp->rq_arg.len >> 2;
>> dr->xprt_hlen =3D rqstp->rq_xprt_hlen;
>> + dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
>> + rqstp->rq_xprt_ctxt =3D NULL;
>>=20
>> /* back up head to the start of the buffer and copy */
>> skip =3D rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
>> @@ -1269,6 +1271,7 @@ static noinline int svc_deferred_recv(struct svc_r=
qst *rqstp)
>> rqstp->rq_xprt_hlen   =3D dr->xprt_hlen;
>> rqstp->rq_daddr       =3D dr->daddr;
>> rqstp->rq_respages    =3D rqstp->rq_pages;
>> + rqstp->rq_xprt_ctxt   =3D dr->xprt_ctxt;
>> svc_xprt_received(rqstp->rq_xprt);
>> return (dr->argslen<<2) - dr->xprt_hlen;
>> }
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrd=
ma/svc_rdma_recvfrom.c
>> index cf76a6ad127b..864131a9fc6e 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -831,7 +831,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>> goto out_err;
>> if (ret =3D=3D 0)
>> goto out_drop;
>> - rqstp->rq_xprt_hlen =3D ret;
>> + rqstp->rq_xprt_hlen =3D 0;
>>=20
>> if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
>> goto out_backchannel;


--
Chuck Lever


