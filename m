Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E635F6B35
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJFQGm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiJFQGj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:06:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431073FEFA
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:06:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296FhkDf009490;
        Thu, 6 Oct 2022 16:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oXIAssv29mpq4ERjEsmuTkMdRDJcNdATI8jRsvMIS5o=;
 b=vNAD/S9F4YUIHWjAEOzzF6dVEkTFyv6nlDBFFG/+bjWp18oG6Jxp9Rj3mfrzUK7tXGkc
 EL0ilurt5eLRhr84p85wWNAIBkmQZKqhz5ohuSMjJRIZpe9C48veGfydtyPH+85RMpxC
 7d/+thZGfTaCmuZvb1K7NQdO4c18t4PkFc9XT5XgB22LD0FVV9N8o8rUKz0Lbqn5PeSW
 iglbROcnANt76zOqFzHRploM7O6BAE1LxDQUfT7G2BFDGx0TBz1RVUGaEwpxlr3RyaB9
 gREBK9cvSEd4j6i+6NEUt1os9d/AY9eDmiaV65qL8GpaovmGLugy3Fo4F2dZMC0pTG+/ FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k15up434f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 16:06:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 296FBmqc000556;
        Thu, 6 Oct 2022 16:06:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc05y65j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 16:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSXOCcdykYicGFWE0SEKgJWp+HynxH9d1IEwPWaP8zRoQjCnEyYlozbimEJvcF0fe/CcB5sqNwecZXYBDm0+Gtqxeceq0EeZCdWQA5rQEysSZeqM7xSpV+IyXiaohBlmdO5wfl3YVw6DIiJQTnaic2SWs7SiytDZIwwy1O3H5p2tTblHaDkHJ3aRWbA4yruLSKLSduvrNE9NWWZ+20IFhquwXi7TN9Rz/NVSrrUf06z8mLGIrRSznN49xDsxqbSvLgQDhHyG1WyBS7PEHpwKoNo79GOf8Ymdwn1/3QcPcXb5iI6XYdjH6hIQWCvbK66gPyGBRIWMXy9jAXZQKoVShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXIAssv29mpq4ERjEsmuTkMdRDJcNdATI8jRsvMIS5o=;
 b=cG3b3P1F8+NdeDDdMUZXQNQhpu02BzsPFgNxdEGy09ykjmHO4QchX5QgN/N09StIgAAwoN2WSDuW1V206iGEnMJB3TS9UOnf+7nP1WFI08QxGr+vGAm+2oreRdM1LlKk7rSHQf8Nnfnft35qpyKzQnr1Sogx3Rsijr1ZkQ+9sk3GD1Ph6IuC4R0AHDLoqwYmD2Z/QONoC4Ile6iA47SAXTuigtkFuzekZyRchJe3l66oD6AN+4+VXiudZRvcUsQYQ3tdOl1CVo3cC+yFpKNqNmLuxcQBoJXvCuGnl7mxVlUQr8wpkMI8OeJhTF8L1+2lXj2UQAdj/Nmq95R6aKMnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXIAssv29mpq4ERjEsmuTkMdRDJcNdATI8jRsvMIS5o=;
 b=zryec2uMp3ysVlFZuJkXI1Np6F1Od8fVrdfrwY+AQ5yHoYmTBMVuFnR353oPk/wtzXQrVruKRndp32Hu6+IBV2x0IrHJMGFAJkSN9nhbZO9AD2aeo3tlq57Rq8Z49xHAbuToSweBIJiIlS6L2tPGC8dxc9DnZQtakRtwFYm1rwo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5023.namprd10.prod.outlook.com (2603:10b6:5:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 16:06:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 16:06:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 5/9] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
Thread-Topic: [PATCH RFC 5/9] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
Thread-Index: AQHY2Mqiq84pLMKb4UW4POknNA9RB64Bh4uAgAACDYA=
Date:   Thu, 6 Oct 2022 16:06:27 +0000
Message-ID: <8AFEB408-8B31-4EE2-B92E-2D9058947710@oracle.com>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
 <166498176824.1527.5576152854743615272.stgit@manet.1015granger.net>
 <4acac2ce88920ec3b25d52ac97ed5739838a85ac.camel@kernel.org>
In-Reply-To: <4acac2ce88920ec3b25d52ac97ed5739838a85ac.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5023:EE_
x-ms-office365-filtering-correlation-id: 84b11f08-f83f-460c-891c-08daa7b4b9ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wazJxJ2bMfjSd96szFLR3kEtybwwD1OAkT8IGvSefo/kSuxDY5rpP7d5gIstDxkpCLr/dRJvUfwrD+8GmJW03yEI/jJ5rpFCIGYEaItWlTe9/tCXvNlZA8LwsC9V2ckq7R0Tv1CeWoSpfT9nNoPtXVeDG/qQarVy3IjXFTI0YKS9D3jLPzmdJAV5N35UKBcBJyNH+c4XlPM25Xk0ZtjQXsAS0Mmy05hByIxYFHU0LF1iVVUxRS3uJ1LGFJQvwRoN09ZbFQ9XsSwmWzpRjs4lVVAW3YPAdTWWGY+zgJIIDK+OkFU+kLVDTG9ueCA8gRhk4yJloOScFydufOAADClI4H/D1tPIy4ISxrj1gR5Ieyj/RjcTWC/2m+qp+95bUHdX7cTgNK3C5szb/1e5gS1Z0Tiz2thFgbSSqOI9irFa4WlZih/zMSq3zhooLjESyImD8ZIqMl7wGdFQuuJfSvTrozkKIMJFAHPW9ykLgHxu3jlpdXe6HfqCiCRI7JEwbiTnS06mLpZ+2sfZmHistsf3Jl2i9db8zaOPFC9iNKkh9mxKF8g/HuWQuQEb6BCxE15pH+6isLB7dDKtgIC9BC8cDo5WauevRoSDNaVPrWb2JWsct9Sp/2Y/JMVNttZRUU5pZJdsoBSeKG25C8tAIJR+E8ef4lC1GxZGiosELumKcpyFWwSPVHc01B4Nw3WjGH7iWzagQJ1bMDDq108ZDzHwPxb1gFIEsPr/nf0ohnVohs6RbuW6KPpr3KgHQNJdp8e+PoXdyzcUV2chQqwDzxfY4MNENGW65LpMe9ciRMxVIR/wABwNYSnSjYcnyVGnpnSPryNMgQU4w+UlClikpfLAdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(36756003)(6916009)(33656002)(86362001)(38070700005)(122000001)(38100700002)(2616005)(186003)(83380400001)(6512007)(26005)(6506007)(71200400001)(6486002)(53546011)(966005)(478600001)(316002)(66946007)(66476007)(76116006)(66556008)(66446008)(64756008)(8676002)(4326008)(91956017)(8936002)(5660300002)(2906002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C5/R6iZhGRghqQmdwO2Wb+/feHSRCZOKMbxjS8HuK0SiwJ/wp1iIgZOBNUji?=
 =?us-ascii?Q?Y0c1i/hbwtc0JzIaIpmS57PMJvlHO72+nIP2sceM3PQkX6TnuwqYtzXwsDI9?=
 =?us-ascii?Q?Kf5yPrdU7XTrrnBSuwN+jaGhvHFNjIVPKKdwVkNuQsXLLZ+RRhNevBUpk8oS?=
 =?us-ascii?Q?MTrg4M05HYWCV28dJsyzcgqGlVX7NVq+i3MIynW0J3RyyPgmvw3phICo4z1C?=
 =?us-ascii?Q?zZ9Ntao55GFPYHuVq/fhU6YG8uCrA0iUJk46ZrDJzVRVWgrFZd5zp+2No/2o?=
 =?us-ascii?Q?iJx46S/HO8oxy9OeoO8dE+LDNpbtST4il/3rF//hIkfnxpz/NAu/5ggrbBWM?=
 =?us-ascii?Q?O4Oy8tFCGgtdKEbPXpPHeAMULhM9xDNOcGlSt4bhhGmgi2nZKcqYAi9bd4QL?=
 =?us-ascii?Q?tfbX68LLNdiwokCyMhI7mUs9yGUKLDzgzJFgDHoaIIyAcfc0uNlmrWJItj7o?=
 =?us-ascii?Q?RYG4oOtMysY5KgWXLSDpUSMdtkdidfvF629YfvpWVJL0Pi7tII5vQZMUv5Qo?=
 =?us-ascii?Q?9J3aHNCI34BuVzzM/uLREen9XM4kBG4nyQgLGEFSGAx8xnh5xyHTmymgre6J?=
 =?us-ascii?Q?Y5KzoyckILKbgHBMxLi0pvZM99I3JoOEvHWDubD8qUqo5ExVqNMKlgpa9GCy?=
 =?us-ascii?Q?GprPaWoA0OlsdBRAal71tu6V0s21U/kPaTc+poa3mHsZgj0zixnraJBzbWDd?=
 =?us-ascii?Q?n8pBHxX93+j6r64teBPIO2fQdraIqj3I3xReJtfAmspAltzn+1Jz6GreBElk?=
 =?us-ascii?Q?nDrqtS2Zfo29Lpr7aXQRq+WxSsJWQ1CPKmb7bCk8IFWDyGEGK710oEC6DcU3?=
 =?us-ascii?Q?FgoxbYLBY1QDMW+B5Vex4syjlVn0H5qhX9Az9DIZh5uiNTLQ9ZmM+2K3DuXd?=
 =?us-ascii?Q?+8h6IPcl8wvPePjnlPvrdLzLKVe33nY9C3DI9kEJZ1V2f2W+FiNaqILE4yDb?=
 =?us-ascii?Q?rG8ovITfvyXU2fXflK0YAZB5HZcz+G8V+qHGD1EEsnZSeUXLCWjRfUrKYMPE?=
 =?us-ascii?Q?uF4JQbJF3to69bZdLaEzJ/w+z8J9jlBmsLAHNqkSvHPyjStJySsiEJbtJmZZ?=
 =?us-ascii?Q?CoxZ5pPvGl1FDElFeU2s2hEr0jD46Y3StSHjOH8n6ShlDRf2uddcuwH+4VcM?=
 =?us-ascii?Q?gYen3m27mQLdkX1o5JfkNUZ80qPtkIRybAmaqDJUQLV8uOqTNJpj/vcFsXX7?=
 =?us-ascii?Q?3cwyMngYXDeVW85XGyf7k1A4bizDiBOf6pr9lcHiaAfdHDwaKY4on9fe0WzZ?=
 =?us-ascii?Q?W1zyFn9Fcm0XUadZBVc/vMj3VGh00VIr2DKVuKUmWzKItcrAoUNlH1z2YxkF?=
 =?us-ascii?Q?KzVqvBLu3Yfal1mH7S3c/hjkh87+3SXXELqtamizdD2QLrmKSglNHLx3cGpP?=
 =?us-ascii?Q?l2Fq5vMxxFeBX66x0bLoslO8bthVm4gu+yX11OeMliu3owh8x7MDIebEpBtB?=
 =?us-ascii?Q?87gP6B9224W1Ps5vrNFlYQFcH1R2v2rbS2+qqtoQaXnVn5FFCOdlYV628dpB?=
 =?us-ascii?Q?b2Mu963TVSZl4cMF2mMPJfOT6I9xxcFMHcnR3aMQQCaf/OvkBoG5aNNSu2Ur?=
 =?us-ascii?Q?2QBX9U9G9rulI+qILh6j4E3qNYcc53RR8vWRiGqHLcfgkfN6O+FfogikkdEJ?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0ABF470006FF42469FC87D1EE8AC47EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6BbKIOnQvxgjaCkDJEcYpOtrtdo0DlVWxwSzckpOPoqXq2rzJ531Ux60BG9WiQ5/mf0paOfrlqWvLrxRejmjNQefqTfx6gV5MhtDLC0ZblyFadm6dZFsDmyUy+8wh8Rv8cB2YnS2l/qfsCbYou2+I4oaGucwjRFr9nQKS9WhOL8HyoAJO8JanWkOQBiJvEIxwel/mV0gqIed1GIIDYPhfP9GpMlYlGM4vRsuhtWCT40UHliJ6Jme613VzqsHWYmiiKlxUEMY+bAmDwzauQ4zoItpWVh22OtTxxbKU5cJCkfX6lQIkr8Iot3giR2wJpnDxvK3jWPpKZbOpvOs9g+EmSIMUKHrxKB6Kpbocyoawq+5wH1zA4vKeIAilyj+4d7Ho9V7y+subGAz7C6h1yKHz3AKpOGHCHoaSD+cNkeoACaQQECGDGf/Gg/51/3iuPi5ciRppXY8OkIH3dU1odeZd5D6Je9/twuUkMsmeucgo1hfOIKdGHXSUs4dLh/m63yl3LY5wpNhcGsDZH7/J6Dar6s5QQyTubLCKzTHOswrptXKiC5Tu8+SIjWToL8Qk33bK6zScPWnxOftsPGSQtwbQma2bp0pq33szKRIrp7V3WD90cbQNUqBd8COdOz2swubyLtCZ5C50plep1kLLePeC2+5cxqwE6yRvqBv/YpIUqEms+jECQWto5A1YwC/rUjLY2HDoAjnhnk8wNd2+6pPHfw6/ZuYOH7C92DXlcLTrcxSujFmJVecUsGhu6bD/02p5L35mZ9ISQ6ZQBqRUtRDB9taQq0Nj1JmbXD0dbNLlyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b11f08-f83f-460c-891c-08daa7b4b9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 16:06:27.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khgVElFFeOHNC7NmBAe9ORtcT3gElvOjSqGMY9+GdGvISI0V2zl9Bh3uu9hcE6iEXUnGZ3ZAuWVQS9IvOa7JVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060093
X-Proofpoint-GUID: EYWg3ylQ44Lr9itTfyXvxB-qHRB3il8E
X-Proofpoint-ORIG-GUID: EYWg3ylQ44Lr9itTfyXvxB-qHRB3il8E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 6, 2022, at 11:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2022-10-05 at 10:56 -0400, Chuck Lever wrote:
>> NFSv4 operations manage the lifetime of nfsd_file items they use by
>> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
>> garbage collected.
>>=20
>> Introduce a mechanism to enable garbage collection for nfsd_file
>> items used only by NFSv2/3 callers.
>>=20
>> Note that the change in nfsd_file_put() ensures that both CLOSE and
>> DELEGRETURN will actually close out and free an nfsd_file on last
>> reference of a non-garbage-collected file.
>>=20
>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
>> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
------
>> fs/nfsd/filecache.h |    3 +++
>> fs/nfsd/nfs3proc.c  |    4 ++-
>> fs/nfsd/trace.h     |    3 ++-
>> fs/nfsd/vfs.c       |    4 ++-
>> 5 files changed, 63 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index b7aa523c2010..01c27deabf83 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>> 	struct net			*net;
>> 	const struct cred		*cred;
>> 	unsigned char			need;
>> +	unsigned char			gc:1;
>> 	enum nfsd_file_lookup_type	type;
>> };
>>=20
>> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_com=
pare_arg *arg,
>> 			return 1;
>> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>> 			return 1;
>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>> +			return 1;
>> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>> 			return 1;
>> 		break;
>> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
>> 		nf->nf_flags =3D 0;
>> 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>> 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> +		if (key->gc)
>> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>> 		nf->nf_inode =3D key->inode;
>> 		/* nf_ref is pre-incremented for hash table */
>> 		refcount_set(&nf->nf_ref, 2);
>> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>> 	}
>> }
>>=20
>> +static void
>> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
>> +{
>> +	if (nfsd_file_unhash(nf))
>> +		nfsd_file_put_noref(nf);
>> +}
>> +
>> void
>> nfsd_file_put(struct nfsd_file *nf)
>> {
>> 	might_sleep();
>>=20
>> -	nfsd_file_lru_add(nf);
>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
>> +		nfsd_file_lru_add(nf);
>> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>> +		nfsd_file_unhash_and_put(nf);
>> +
>> 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>> 		nfsd_file_flush(nf);
>> 		nfsd_file_put_noref(nf);
>> -	} else if (nf->nf_file) {
>> +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D=
 1) {
>> 		nfsd_file_put_noref(nf);
>> 		nfsd_file_schedule_laundrette();
>> 	} else
>> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
>>=20
>> static __be32
>> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
>> +		     unsigned int may_flags, struct nfsd_file **pnf,
>> +		     bool open, int want_gc)
>=20
> want_gc should be a bool

Well, that is a little easier to read, but...

I set key.gc to want_gc. key.gc is an integer field because
I compare it to the result of test_bit(), which returns an
integer 0 or 1.

I think I can trust that bool false is always 0, but can I
trust that bool true is 1 everywhere in the C universe? I'm
never sure about that.


>> {
>> 	struct nfsd_file_lookup_key key =3D {
>> 		.type	=3D NFSD_FILE_KEY_FULL,
>> 		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>> 		.net	=3D SVC_NET(rqstp),
>> +		.gc	=3D want_gc,
>> 	};
>> 	bool open_retry =3D true;
>> 	struct nfsd_file *nf;
>> @@ -1117,14 +1135,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 	 * then unhash.
>> 	 */
>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>> -		if (nfsd_file_unhash(nf))
>> -			nfsd_file_put_noref(nf);
>> +		nfsd_file_unhash_and_put(nf);
>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>> 	smp_mb__after_atomic();
>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>> 	goto out;
>> }
>>=20
>> +/**
>> + * nfsd_file_acquire_gc - Get a struct nfsd_file with an open file
>> + * @rqstp: the RPC transaction being executed
>> + * @fhp: the NFS filehandle of the file to be opened
>> + * @may_flags: NFSD_MAY_ settings for the file
>> + * @pnf: OUT: new or found "struct nfsd_file" object
>> + *
>> + * The nfsd_file object returned by this API is reference-counted
>> + * and garbage-collected. The object is retained for a few
>> + * seconds after the final nfsd_file_put() in case the caller
>> + * wants to re-use it.
>> + *
>> + * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>> + * network byte order is returned.
>> + */
>> +__be32
>> +nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		     unsigned int may_flags, struct nfsd_file **pnf)
>> +{
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
>> +}
>> +
>> /**
>>  * nfsd_file_acquire - Get a struct nfsd_file with an open file
>>  * @rqstp: the RPC transaction being executed
>> @@ -1132,6 +1171,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>  * @may_flags: NFSD_MAY_ settings for the file
>>  * @pnf: OUT: new or found "struct nfsd_file" object
>>  *
>> + * The nfsd_file_object returned by this API is reference-counted
>> + * but not garbage-collected. The object is released one RCU grace
>> + * period after the final nfsd_file_put().
>> + *
>>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>>  * network byte order is returned.
>>  */
>> @@ -1139,7 +1182,7 @@ __be32
>> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
>> }
>>=20
>> /**
>> @@ -1149,6 +1192,10 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>>  * @may_flags: NFSD_MAY_ settings for the file
>>  * @pnf: OUT: new or found "struct nfsd_file" object
>>  *
>> + * The nfsd_file_object returned by this API is reference-counted
>> + * but not garbage-collected. The object is released immediately
>> + * one RCU grace period after the final nfsd_file_put().
>> + *
>>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>>  * network byte order is returned.
>>  */
>> @@ -1156,7 +1203,7 @@ __be32
>> nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		 unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, 0);
>> }
>>=20
>> /*
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index f81c198f4ed6..0f6546bcd3e0 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -38,6 +38,7 @@ struct nfsd_file {
>> #define NFSD_FILE_HASHED	(0)
>> #define NFSD_FILE_PENDING	(1)
>> #define NFSD_FILE_REFERENCED	(2)
>> +#define NFSD_FILE_GC		(3)
>> 	unsigned long		nf_flags;
>> 	struct inode		*nf_inode;	/* don't deref */
>> 	refcount_t		nf_ref;
>> @@ -55,6 +56,8 @@ void nfsd_file_put(struct nfsd_file *nf);
>> struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>> void nfsd_file_close_inode_sync(struct inode *inode);
>> bool nfsd_file_is_cached(struct inode *inode);
>> +__be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index d12823371857..6a5ad6c91d8e 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -779,8 +779,8 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>> 				(unsigned long long) argp->offset);
>>=20
>> 	fh_copy(&resp->fh, &argp->fh);
>> -	resp->status =3D nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
>> -					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> +	resp->status =3D nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE=
 |
>> +					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> 	if (resp->status)
>> 		goto out;
>> 	resp->status =3D nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 9ebd67d461f9..4921144880d3 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -742,7 +742,8 @@ DEFINE_CLID_EVENT(confirmed_r);
>> 	__print_flags(val, "|",						\
>> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>> -		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>> +		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
>> +		{ 1 << NFSD_FILE_GC,		"GC"})
>>=20
>> DECLARE_EVENT_CLASS(nfsd_file_class,
>> 	TP_PROTO(struct nfsd_file *nf),
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 44f210ba17cc..89d682a56fc4 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1060,7 +1060,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>> 	__be32 err;
>>=20
>> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
>> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_READ, &nf);
>> 	if (err)
>> 		return err;
>>=20
>> @@ -1092,7 +1092,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *=
fhp, loff_t offset,
>>=20
>> 	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
>>=20
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>> 	if (err)
>> 		goto out;
>>=20
>>=20
>>=20
>=20
> Looks reasonable otherwise though. I like this approach.
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



