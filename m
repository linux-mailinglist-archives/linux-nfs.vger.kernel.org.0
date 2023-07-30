Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF7768939
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 00:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjG3W5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 18:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3W5Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 18:57:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C0123
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 15:57:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UMsf2I020084;
        Sun, 30 Jul 2023 22:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WijBjj8jC9CxGROj4pyu3d5Y9Jp8cYrkEkQLFoJCQG8=;
 b=QUckuudJ9UBkxLNxZZtPNoDj+aAxF9NREDfP077lWHQMAAp9/B/Xq2S2FhVrQQImEPm2
 SE8wkRFKxYCtSPRlZRVlYi+pXv315/o1Cl8dfdxu8Ws+tw1gJ8AHdpXcUa4WFxE2irqF
 TE9rX7oMCltpj7Cz8Lv8+fzOCdoEZPWcIJ4DGZDBaKvDEGtgjxRIfXEfTuO5B5WaLTDh
 ZHTe2POsL5/7cUsqueM7K3P/WmZ7yjBtuzqdDKjvYzeZUqgBMq20Tn5LSUDGWhsSXypA
 uatsK0zfu8Foz2TJfzzlzD0vqMGfgZy6lnMdi+GPPFN4l2a7zEvPs0mgsfJSwlfp6Vfp 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd1fej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 22:57:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ULIHgr033566;
        Sun, 30 Jul 2023 22:57:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s73vqfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 22:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMquIJqyPZJf4ZfB0U1ugDXtEEzIgWtXKk4XTKhJOnu4YU6JkzNHZ1QfrRT/ewdsgkY/Z0G+tXqh4f5CbnSrDBQu66+340evsoPnFMHieAJPlAk9MQa9na4ZgSC2Cabja+5/mjPxF77mhX/8VkiCPtFYU28v1KFXzwP7LlZuiIDzu1VNrwHmSuHwC+96iYTecpYbrC86y8SQIPucStu38IKyY2SIsGd3zFRK0964jmsLoYNCk9EqL8lhi4jAFxE1eThrZQ1NGiNhsUD6i+Hxsir5Ul/05w4hz9UVKNKENoe6In4T1gdhekTCJLQrqNkNRaTpTGyHrJkBAaKDYi1RBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WijBjj8jC9CxGROj4pyu3d5Y9Jp8cYrkEkQLFoJCQG8=;
 b=JDlpDSoKUv2UfjQD/oBWVGCQ2YuJFApjuoE9anc3LxflzidD1zKBZMRmLymmfbnqYm1BzT13kzqJQgj2QdGic0NPMX07z7c0/aCGpRCH0V3H14MER8ZyJcxrsXKEaH/j1fDED7AhFb93X+xrV0umkc2q5B0sO0jqfbao1fg95k2L4NOGVpLiOI4ajJ5Ks+qyeks07/ACePTJOG6g8uB3rbQ7xRI52VzI2HEwDqa1Ny/PhSxhKfemR2Xg1BE7XeAP/53j/7BkXj2Qqtvkw3bZ2Ib+RlIARrTCUnYbCn9J6zoASh88r3dUmdEQfdpxzH+0xiyp7deb/k1M8Cc0CT26/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WijBjj8jC9CxGROj4pyu3d5Y9Jp8cYrkEkQLFoJCQG8=;
 b=sEmiJWqixS7GgHUto2YUvG2aJSNlOVXsNaXpU8Z4ry6Uh9Vkxr5k0v7uKGtE5KAily+gBwDm1sBGWnalZhtgkNl5hu114fFFNVXUHLGlKmskL/uwPYxgIm85s+UFZ+RZadlpVKB0ESsPo3C5dKp1f84L3g7PCe3ZoDFNvR7CbrM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Sun, 30 Jul
 2023 22:57:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 22:57:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
Thread-Topic: [PATCH 06/14] SUNRPC: change various server-side #defines to
 enum
Thread-Index: AQHZuUKeUhPN688TTEazI3MFmgB5Iq+/h5sAgBMC4QCAAHUGgIAAAEOA
Date:   Sun, 30 Jul 2023 22:57:10 +0000
Message-ID: <F63A3F6B-D661-4545-AF4B-FE3A861305F9@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228863.11075.8173252015139876869.stgit@noble.brown>
 <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>
 <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
 <169075776306.32308.3045406213067424206@noble.neil.brown.name>
In-Reply-To: <169075776306.32308.3045406213067424206@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4999:EE_
x-ms-office365-filtering-correlation-id: 6f367541-b1fd-4000-2237-08db91504e7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXssZQ6kjjHb2vxnClzCcizC4yoMxErT3aB5xlhxbalrPw9rQpSWph5f1YQnVNIWpVrJGZlrH12UKQEXGmXjwcL1LgSXQsRb8XuO/vyHlJ9h1/Fh53PC46JNYmk/StjzWLmfHyT6IJfHCvcLgnbKqebfo6T+xVnCaXl7n3umoaN0FmLjTWWbqM4nWnUB7wNjTHoONe3X/jw2cS+r4gJwSpkBtOPMZKSQXcM586CsVPD9Aap1brC9XNDXFzi0vM3PShyK9vK67qU+AV5cox0wveoQh4R+144uItoey8Y4U77LygzXswAAjvTpMWuVdRw7ZDCrD2kxexYCsCfLCsOEghtIks+SenY67xkg+CI2Mj0UHrJ0c5kzcQ9qlZChOne4QgK54YqW9ddDdBF8rtGTlKYbGUO9KPhQQxtl0FK712Yv6EdCvf/WXEqng6gVyJBvn2MfZRebu5f4XrDOLEGuKQjDjidqDbVaKM18GY1KpkX+TqREEVftRaSSQM2LaVcNTg2gszmNoIatrnB0kY7+HAy8tjQ4HqQpy5Oq6RtwHLLkFcZDOcLWPts1Hlyf+W2Il2hfB9ico989w9OTcZx/T+Vqp77gLQ8lJPNwLqIiiQZyTvDnb2xqtpW+DLXtWqh+kewXNKELMjDyjK7hl8yNjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(38100700002)(122000001)(36756003)(33656002)(38070700005)(86362001)(6512007)(478600001)(71200400001)(6486002)(2616005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(5660300002)(91956017)(76116006)(6916009)(4326008)(66946007)(66556008)(66476007)(2906002)(66446008)(64756008)(54906003)(41300700001)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JmA64fopnmhD+mkBscnO46G0p8EWKCi74L4uZ1WKU+/B+/X9qVinRPSfv/M2?=
 =?us-ascii?Q?VwBJ7xZJBpsk5pzjMyGREzyfS6VfUIAaTzjCBBBJZZyrLAiH3v0KWJp0Y8up?=
 =?us-ascii?Q?dW+4+K4qeHG7f0qHpKPihX3Q9AEagjmwsljZ3hWN7n1RWW/pBqO8IJwGPW0f?=
 =?us-ascii?Q?cESLvMgv1mFCC05vWm8np5IDpmS7jvSfgNqL92PtUa8xpMYSVROny0iSmPja?=
 =?us-ascii?Q?L3lOdVWI50GGPeSt2+MrPqj5O8q0gR1UGn6Nxu3K42Uyski9AE2cE9+ngsbk?=
 =?us-ascii?Q?Pk9AIlX4LXIAGczY8OB2ZSsCBXTcCVmFQ3aAtp7jzizr0CMY/M39O7+JM5dF?=
 =?us-ascii?Q?ndsa1UUY5unNhAnxQa/NdDZzKpXybIBdWlVCUvH0dcp8IDTxMtL/zSrmK0sL?=
 =?us-ascii?Q?6WcwZb0NpmLk1TNeYZ5uIlRryt9Rkc9Vmn2QMx2fIQLmzCHe9mwNHU8OeFSr?=
 =?us-ascii?Q?rNHJtOOmq89SXsMr4zpv26nXGRMyTwx/eHsC2nEJujpZUjwpNA731ZOcDh86?=
 =?us-ascii?Q?4euwcGp64TksXs2gOb+CNPPOiapGz9yJkoeKCMLGLroKliAOBxbjrJqDllH9?=
 =?us-ascii?Q?mzEgeRD8Hes3PYHw6q/iNVmYbLXcFHgb+uRq4FF4Ili8V3ovAhsaJEp0u9c+?=
 =?us-ascii?Q?K+38ibfqQc1YvsAQrpPIf/GtEEaxX2qjrB6gywKHGc8y/nFSMLmfk83s4N24?=
 =?us-ascii?Q?g6OfCsEgwpGtY/6+RwXfCvhoiPifCMen6wObrChccbCIeNaSmiB56eIyw5Tz?=
 =?us-ascii?Q?Anf4wC2N8wxyN68G1jYFY/Aj60QkHovxdF05r/nvHqmMB9akdA8xZYpNyLoU?=
 =?us-ascii?Q?s2WCNDxlw1M/5+orli58eiRYJrT3YbuiYdA+eAfR62Y7/hz+dIea8y96oHwY?=
 =?us-ascii?Q?TJyua3YLV7MYXX7wRQxXgzpdXHZZGq0qx+E6rzZ/mLyz8x0JkgEJy9V4OLb7?=
 =?us-ascii?Q?SBMpxlI1QPNY6UWinrs5+7ps2rmZW7Tpr9GCdIOv8Dx/n+OdMXAwaVwfAkLB?=
 =?us-ascii?Q?gP085QlzolLLhwio0ymI/rvCQlKX+GRMlUvULlsiU1JzUXSvCRiaB8NDwU89?=
 =?us-ascii?Q?nqhU+eg1zK2EMDtmHHfF5FJrSeSO/C+KL+5rkgWPu3tvcUQhDcI/S10RbJ1T?=
 =?us-ascii?Q?N4Kl8KJvo/0Of6uh7DW1xjdyG95fHydQ/OJcshFp1SsRmGWeAiHZkU8TGx4R?=
 =?us-ascii?Q?/uXcflVUTOVUj3Q3wDQDpJ0vJPJSOXiEoGY9nDVrU0y+aXaZnvj5dAyH0+/J?=
 =?us-ascii?Q?/Slb36SWd/96o1/6z10xeT/fGYCsBsVuRnCz7HyIAdPn1CLXUMxH59mRlyK7?=
 =?us-ascii?Q?X9MIda5hieAV29KqAuLbbXhMGda6LP3f7zmYSEnrqZp5kRppY8iCCBu86koG?=
 =?us-ascii?Q?8RDRuwL0Kn+6wEcKVFpugdrzv/IunAlEPm2vq1JjXTZbxZaaUpiAMyeGyC/W?=
 =?us-ascii?Q?bUVhw1sbe2bBJFzbZJqUsGwKOr2SZz8yu8vzEw21HNyxxuWobirXR0mNeKJl?=
 =?us-ascii?Q?dNjadQFWyRcREWQBHSeHtaJrQdg9F1SFOLVuZyLThx1mh0kLbwhrAn3Y4pZn?=
 =?us-ascii?Q?GP5K3v9u3wnFJCg3UvXL7KY5/n5bbWO1QbUesFNv6V/tXaLuzcGVTVErCrP9?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BA7829D0A4CEA409571A3E8CC9FCBD7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CJFh3wfDsSju5TMREIlpGAJlycK3FDW1u4D/8DTRztlQZy75RvUosOnj/Ti4VqADqkZ32mO1h6hS8qeeq8xaxNUD9BC8Ztb4ez85n73x5O91ak1fVo9WefWeFZ31hrGOKk1bY8OkK509bpkISCIPKPUCVFVP/decD97L56Slvgw3/+JUJGUZrnpp0reV/vpgCQusWpcj2lPtsT/GeCq4rTw7p9/SbgYBNI8xQM9ev/09Blbk0zBCLRZL3rM4cjM/tzZ1MyV/za2wYAZt3AXwbC2bBNr6R5WwOB7kVIRZD+VqUyEbDaU1JBeeMV8+oxF000pz7AGjxuF5k+/DE5OBDq1lP+uYBWw+i9XM9frMK8S/BkEawU/MHarP7zUEG/14o7s6viRDWscaid2mibQSdvl692q1PbpRzh3ujB8XNwyKOJBioj7mpg6hegp7eGTY+boQog/3x76lbjKWaapGBMWhUdiDRTNaQxwrgGV9guL8wc0WATpg1oHC+lmf/wa5LxmaNHIP2pj9xgsYJPXOz8ERZWw65Ub4ajVHQVktHGR+mXSHrFiFsmPXg98cEbBEtK+w77qbIDSBhpZl6QQMY3Chb1iH5RRqZSIx27XphprYhvpOvT6vmcinpsPQfojf9/HYQzg3V1UgoycJtkiDM2AyRud1r2SAN3dqhjOjBwKoHqYthnb5XnNDAkKO6wVU+ArHcGtzo3AQIQ+i6inqesKG7PoFYU2TS+sKD48bIf8XvxcnZvyu4qZS12r4Fku0ZatUs/eGV8FwhDdZLHoPvGl3osqr4UMlLkEivUJwcllNTHrBtJWyk+y+tQM5uLrV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f367541-b1fd-4000-2237-08db91504e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 22:57:10.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nzpOLDfpdP8HdV4p73ONsljtpDM6w47ihOQczE7AaazrQmk6fq8Xr2di24PKm47e+Ggw3TncrhDTY9tQr1b/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=757 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307300214
X-Proofpoint-GUID: gG4wr5jOEgaTgnSt2rjvQS6XrCu9GfS7
X-Proofpoint-ORIG-GUID: gG4wr5jOEgaTgnSt2rjvQS6XrCu9GfS7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 30, 2023, at 6:56 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, 31 Jul 2023, Chuck Lever wrote:
>> On Tue, Jul 18, 2023 at 09:37:58AM -0400, Chuck Lever wrote:
>>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>>> When a sequence of numbers are needed for internal-use only, an enum i=
s
>>>> typically best.  The sequence will inevitably need to be changed one
>>>> day, and having an enum means the developer doesn't need to think abou=
t
>>>> renumbering after insertion or deletion.  The patch will be easier to
>>>> review.
>>>=20
>>> Last sentence needs to define the antecedant of "The patch".
>>=20
>> I've changed the last sentence in the description to "Such patches
>> will be easier ..."
>>=20
>> I've applied 1/5 through 5/5, with a few cosmetic changes, to the
>> SUNRPC threads topic branch. 6/6 needed more work:
>>=20
>> I've split this into one patch for each new enum.
>=20
> I don't see this in topic-sunrpc-thread-scheduling
> Commit 11a5027fd416 ("SUNRPC: change various server-side #defines to enum=
")
> contains 3 new enums, and the XPT_ and SVC_GARBAGE improvements you
> mention below cannot be found.

Still testing this.


>> The XPT_ flags change needed TRACE_DEFINE_ENUM macros to make
>> show_svc_xprt_flags() work properly. Added.
>>=20
>> The new enum for SVC_GARBAGE and friends... those aren't bit flags.
>> So I've made that a named enum so that it can be used for type-
>> checking function return values properly.
>>=20
>> I dropped the hunk that changes XPRT_SOCK_CONNECTING and friends.
>> That should be submitted separately to Anna and Trond.
>>=20
>> All this will appear in the nfsd repo later today.

--
Chuck Lever


