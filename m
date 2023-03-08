Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2565F6B09E1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjCHNwm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 08:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCHNwb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 08:52:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895639BA6B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 05:52:14 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288EXKp026682;
        Wed, 8 Mar 2023 13:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FHd9Ge0G4ekkijteKXtSjBA+FuWUwYQa0EBItdSY4EE=;
 b=F7bfdWtQuPu8pYhWLWeVX8viFNWM7e6P5d1HNV/OrLGVVAJyPku7HuzF7Rlcnn71JSnY
 py6tl6Qcq7JLdh0Jaoenep9FC10izOtzoihncGZ7ZztnxUu7Kxks6gpFvv3kelTOrsrA
 ZSuRBS0jUwUCqqJ25SJ1r6yZteCJhpbSa7Ns3mw8Esrnh2icLdoQurII/y9fcNBpoJtf
 8P8HYC90Zj647CWieewVdPosgCX128caCNKk5/K7pKH/IbTaVYINNPFer2NRmlvZIjDr
 SZqy+4up6Xt0vVxwZvqn2/38/bstcDjnZHouvIDJcE73Xzuz+xzQWv6aTmOGPGpiF/Nb 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y04w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 13:52:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328CdeW0015486;
        Wed, 8 Mar 2023 13:52:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fem96tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 13:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWzMymMgMKM8GNI6hJyWHkOQx+J9admtLJPAv1Y7SkmV0C5wtbgiKpjTQId7DsuiB1FshQuq26bwiBP1a6KOGe+x37raaZmj4v1R0Kq0kzToxgD1s51rZTB8CTB0S4MczQk74kGC8H3C0Smi5nGwBmfY8cUEeM2O2ho3BXzyM9087OJ13JSaS+Np3IfWDe6qJA6fb7NQ9p6ftVYgoUzAHncDGdGyF9QHEt8i/T7AVVGOtSrgHTD9wxG10xyGDfwr9yDU4NzN0K7F14319gsLFU2weO65nz61XTIRFNpqKoo4JB31W7Gw74MzAU+eh5+wyOFEL+06U5u7BSf53mZspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHd9Ge0G4ekkijteKXtSjBA+FuWUwYQa0EBItdSY4EE=;
 b=oXBRlgth1vx+SwwTX3sLqFKbaKiI0ktKEvkB6RYRp7yO5PuIqcy2Rl2cgG78+IhUKcrjj188+n8CzPMr4Z4P5rleO4OcgaHWOtI7CJOqAKQWCLhZiVbv01OzTR8xzrL95OnWAwMggOdVciZq0kbaoX5CO9UCofJ5yz1SaqANaSkZCblRKRQGcaoLZrIS6pHF41lf5J6IiXMg2ylPqdov7E/oYVsJEQu8z7BDRFT99iE0BZGnZvGtQspxt5ZRhPpE4NAPbObrtVCaY/L5CHwAsbY1hSr9tv+M9H5S/nhwB4/KAzeKAc0Mv0milJ+g9ZInjknK2e/wKsmvujtnUJ1Wdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHd9Ge0G4ekkijteKXtSjBA+FuWUwYQa0EBItdSY4EE=;
 b=Qv2ir4fOXux+lRVVWybdPw9O3afhAqeIp91emyOPLlZbCNI7p5dXU8SGFdxqmrHo5Q5YE6XDn76dN8ogOFOJ+R5PFnabQ3CNVY+8hIHntfdoKNK60su2/ic6EcPCd57Lrn9TEHJoVGs4IrpCngFEvig0d3kflanQDakdOfdIETw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.31; Wed, 8 Mar
 2023 13:52:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 13:52:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH] SUNRPC: return proper error from get_expiry()
Thread-Topic: [PATCH] SUNRPC: return proper error from get_expiry()
Thread-Index: AQHZUYpeEnYYHsI3SUS/OXrZaxDUNq7w5z8A
Date:   Wed, 8 Mar 2023 13:52:04 +0000
Message-ID: <FE3AE30C-924D-4828-9F94-3A223AAEEA92@oracle.com>
References: <167825826081.8008.16276753342643583003@noble.neil.brown.name>
In-Reply-To: <167825826081.8008.16276753342643583003@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4689:EE_
x-ms-office365-filtering-correlation-id: 10cf5ae4-d6d7-4dcf-131d-08db1fdc4cf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzKZN1Qon0RnRG0VDZe4XK+4ln12YV1+wTizi6TNz/O6RrWDJE0O8hl6Atrj+nWS+0LnjZNs2d0nkimaRdMkOIPXcbU1TTFl6ISa3yBunwzv9S1LB3NIcq6A8cFx6AlvH46l4hm/0I8GxLklovbxU7GlyMp9esTYvS5Ubbhv6GErF8+2tjkO2dBPh2wMogvU/BJliR5BHuZGXgAKoOpmcVHxrKzPWoA0A1mwpSDbDucijlWRjAQ6Tu+C2S81HH1ALoKSLhq6ZzkEWi+uYDpkxCjNORkpXWj63V3cZ9DdK+gKL8itCCI/8QnxBjyjTi2YmoYgdVBxzL8ptq5t68BM/fB/1APf0a5CVZDG+Ui8MaajJisIhFi7wT6Jdq4T005a3u9OpYo2Qf1bcAt0UZsloiMvrNqqYFk7LmYEMOqwT/ZsLoR+iR8low76uSiLovUXJMlefdUpgOxkNo1cguYjaEB60uL49Kg4d+aBSGRdRffarDrGDdLYvBu5wghMDyy0yHvVMa7e1hIcQELZ2iLijvs5uHdusm5Izk+Ndj1m01V8IuF5/1tPmzlsd87kRWC0jPwtEU4q1qg8Wdnza4FDrUkaVVnm++0ZI8zy2YJW6HQ6w6KTOokTU2hPMCqBGNt7RwI8rQJqbB/FzSTiCTMbqTArs9IgBuaf6DAHdnfIQFlff2tPOSOOFHaL8bjhSfvAmRiRptQPKGiv+vZILLU8J/7W8htCE+qOJedVJucdPmw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199018)(5660300002)(26005)(2616005)(186003)(53546011)(6506007)(33656002)(478600001)(71200400001)(6486002)(2906002)(36756003)(6512007)(83380400001)(122000001)(38100700002)(38070700005)(66476007)(8676002)(6916009)(91956017)(4326008)(66556008)(76116006)(66946007)(86362001)(8936002)(66446008)(64756008)(54906003)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y54mWXinSrxH8dfSwp8hTa68iOIgCyVzuc2IYGHDfhl5e8+6n8fDbz7KJWR9?=
 =?us-ascii?Q?eUQ+DFMjYxULQdM6+UWSSW7MceGZ/HBbE8+JYsJd++/43wXnzNhSOrNcuh3j?=
 =?us-ascii?Q?oU2rpCvqcZil0l7tSGTsg/+4geQX6hIWnJlWdMczL8tKC92JwmgUyt/kqXEq?=
 =?us-ascii?Q?hcTPAprh7xadKY50+ahry6nEe4RFJKuYTr9jEsJVweBTSKBmi1sstI7zl/Ew?=
 =?us-ascii?Q?DgLW53JeELWkzHNJaKgc0drLyIRtRGghT4KmK8T7Im6seGJwwXOfAqWRsdpf?=
 =?us-ascii?Q?p2f9UdjcyJyxf20slbfOdaLf2fRU/otrJdSVQkm5l1I64ClhqF0DTF0fshN9?=
 =?us-ascii?Q?WilaOWG9Kl4ki2u5VDsEMLdOjC1nbUw7IgFOKwAoOgpLYnZm0bs2cpJXCIkr?=
 =?us-ascii?Q?LtApY433cHRmqdSruyMBlsZszbT+rZJEFIM531XIUzA505IxFdib6ymAW2L5?=
 =?us-ascii?Q?yAgIN+2S2CJwjnbmJZ5cKNDX8/SmeTVn3Z1JoYKKTyOy9XX79bk5F2+b8BXy?=
 =?us-ascii?Q?GwDLDHoIOLPOOhFOmb7gDaa75ck39p/rTZgHOy4L78At6cLdCE6HM6ErTR5f?=
 =?us-ascii?Q?9Bn0D2gvzDvwNKFiuN69XMYzxoJfd/jEOok8ZHy//cBwQUurCukxPESc5nYp?=
 =?us-ascii?Q?zAD3EtMQobC/nmsYPOD6Uj5Bse+5hmzxgL+lzutmgQUIUiFgWZw30fRb65dt?=
 =?us-ascii?Q?myHyjPoDF0noAyGkYLmH0tPO4gsp1OOBu8jeel3WZjDOp2r3qwPqF55CUrhD?=
 =?us-ascii?Q?QcUpEvhkHh8T/pIaZXOVVTcH3krBIqZFz9B9XDV1eznEKqqVwE4+deam0eK9?=
 =?us-ascii?Q?O0y2EIlfqvY4lBQIFoKC0I30vntoD4fo0W8eBBLov3lRiicDu3AQS2zwpo+b?=
 =?us-ascii?Q?ddzdbEPJzO9/bN6JAg641xStjSDBSvJD7AkY1x+D4dsY8VoSq4R7IkXxOVlX?=
 =?us-ascii?Q?RNKT3oin3NgqMI31HZIj++4Hi3/dIEaXz0XFqpiPYA8TFZX7ow4NAPtzvq73?=
 =?us-ascii?Q?6grNYOhI/G05nCplaE2u4cSlRUq4ZPOgLAkq6lzpumBg1rPXhiVca3M7vK2S?=
 =?us-ascii?Q?yqoHXbBEwMCfgwSFbH+fsRKgBYk2WQTMyJaPMrYIlqn8VOs7MmieR8sKbHNf?=
 =?us-ascii?Q?ecydeKji3NJGq6NNPX8lc2fHc6zCOU9q8eLllBFFC9DzFpc3AmrQ3Jhwwboa?=
 =?us-ascii?Q?MfCHZiwe/I4CZiOuXmQxm+3uhQ6h56vMd9EnbADOzdVw6KLUnqvQLQZ6+SC9?=
 =?us-ascii?Q?Mw1Ia1jPVu65Gzs/kq2Axq+vMtwwKzVsCPNS9B/+RNh9rcLxqCdv789nE1vO?=
 =?us-ascii?Q?HtItitCHdVIp02EbNqAnSGMcJNN/hG7jtGsnEMJRIxFJfrRJhm5VKt8FboT9?=
 =?us-ascii?Q?TgRqVPSDIWvkQ5IbjcX0YQSBmxXTtl9RA9HgxL0HXV6GLHx2nhhU9OhyA7Lg?=
 =?us-ascii?Q?k1RVTJx08ESli/lPLWbrOkOF2SRaUCOvTacZmM0Vqy9zpPlkrobUU01kxXPw?=
 =?us-ascii?Q?+irKdzvsAbk2sPt4GE2v+QIsSo8SR4Aalqn/kHKFzJkshhgqJlJ4INqBfqxw?=
 =?us-ascii?Q?xzLWjIf2poQmyCLMlj2K3E2ieIgLXCxRF1xKYAATkydf4x29FOl/J8d7KxsH?=
 =?us-ascii?Q?Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <386888B6CB211D4586C8E8A397D96F28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qq8/b89zOKbEBc8Z5JZJCad3/oMoaYvDVul2CDg5CNc57pf2a63xtutrvzrS/EAD8LSszHKHtmqU6RyIgkaSJJ7Y4S04jpDZOg0/6TUgLZ4KcUoBHF9MIw6HIkKlsnVdAKweXmkgREMQYHMZpuKg2wF1It9MRWQQPj45IRix/Yo+1Tm2gS1totEUZuPDcqcrKW7p4yVoGvpkHCkTsjpC6GchfBDAo6CllesoafLC1T6ydyazTwwU2o/RT9DYYiGs3cJlotEh2NZaPD6qCBLW2jmfCCgjoEtfAXC/kj4YHub/VLnKgFXHUcvsYmrK+KG/T/wTgPQeQBmmlGMvsSr+B6j+nj0ZBXZ7X/bdl9IdJ2oml/L93uwMQw4a83kIn2XjIAjoCXiEVR+9GbRpLBOUQ9UzpizyF8sHBQWismxkEDovUAaZf3cnKIPNjBkbGWWN80Hs8uVyLCsNAof2PMUQuKeKin+gEauwPZkLLh9BhBDO6xZSTRO98HaEIzL4sK56uxByF6wqdCQwV8pzyyakN7elTcmiMykO76fGGREcqL3cd8vH+AHZTCSejVc9WwcjRhKBzvf9yDspn9D+SNgd576edSDGI4HrZcHp/OjDLSwdX4JSiEUSp7HbmbLVvdY/pSw89QTFu6mo07Ghbl9y/gkGOHkbl0OZFb5tWGP+ClIHaLqBXPMoavVrTJI6q6SxBVLgPZZgJIlb3Zy9G8u0G8d1SfrtSytlMzF61lI2ylVQall0VcXjxhgX9YJE3oKL9QiPe/lq+RVIx/F7oIbs2VonWE9TD6GOXDI5hgkBQTrkYVlFO5aRVefVwVuGEfKD25qxSO0LLE/NA/D9WByQvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf5ae4-d6d7-4dcf-131d-08db1fdc4cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 13:52:04.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmByUuVk+VJ22imBQTwoUoSgEU55JaREuwqjpj1sVSbyDleXv0cYaRvdzF6RRtyVj4KHvyNCDzi5Bci7BuPzXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080118
X-Proofpoint-GUID: 64HisbJhZj3mjwSVElyg_nATxsg1PGhM
X-Proofpoint-ORIG-GUID: 64HisbJhZj3mjwSVElyg_nATxsg1PGhM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 8, 2023, at 1:51 AM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> The get_expiry() function currently returns a timestamp, and uses the
> special return value of 0 to indicate an error.
>=20
> Unfortunately this causes a problem when 0 is the correct return value.
>=20
> On a system with no RTC it is possible that the boot time will be seen
> to be "3".  When exportfs probes to see if a particular filesystem
> supports NFS export it tries to cache information with an expiry time of
> "3".  The intention is for this to be "long in the past".  Even with no
> RTC it will not be far in the future (at most a second or two) so this
> is harmless.
> But if the boot time happens to have been calculated to be "3", then
> get_expiry will fail incorrectly as it converts the number to "seconds
> since bootime" - 0.
>=20
> To avoid this problem we change get_expiry() to report the error quite
> separately from the expiry time.  The error is now the return value.
> The expiry time is reported through a by-reference parameter.
>=20
> Reported-by: Jerry Zhang <jerry@skydio.com>
> Tested-by: Jerry Zhang <jerry@skydio.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks, Neil. Applied to nfsd-next.


> ---
> fs/nfsd/export.c                  | 13 ++++++-------
> fs/nfsd/nfs4idmap.c               |  8 ++++----
> include/linux/sunrpc/cache.h      | 15 ++++++++-------
> net/sunrpc/auth_gss/svcauth_gss.c | 12 ++++++------
> net/sunrpc/svcauth_unix.c         | 12 ++++++------
> 5 files changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 668c7527b17e..6da74aebe1fb 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -123,11 +123,11 @@ static int expkey_parse(struct cache_detail *cd, ch=
ar *mesg, int mlen)
>=20
> 	/* OK, we seem to have a valid key */
> 	key.h.flags =3D 0;
> -	key.h.expiry_time =3D get_expiry(&mesg);
> -	if (key.h.expiry_time =3D=3D 0)
> +	err =3D get_expiry(&mesg, &key.h.expiry_time);
> +	if (err)
> 		goto out;
>=20
> -	key.ek_client =3D dom;=09
> +	key.ek_client =3D dom;
> 	key.ek_fsidtype =3D fsidtype;
> 	memcpy(key.ek_fsid, buf, len);
>=20
> @@ -610,9 +610,8 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
> 	exp.ex_devid_map =3D NULL;
>=20
> 	/* expiry */
> -	err =3D -EINVAL;
> -	exp.h.expiry_time =3D get_expiry(&mesg);
> -	if (exp.h.expiry_time =3D=3D 0)
> +	err =3D get_expiry(&mesg, &exp.h.expiry_time);
> +	if (err)
> 		goto out3;
>=20
> 	/* flags */
> @@ -624,7 +623,7 @@ static int svc_export_parse(struct cache_detail *cd, =
char *mesg, int mlen)
> 		if (err || an_int < 0)
> 			goto out3;
> 		exp.ex_flags=3D an_int;
> -=09
> +
> 		/* anon uid */
> 		err =3D get_int(&mesg, &an_int);
> 		if (err)
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 5e9809aff37e..7a806ac13e31 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -240,8 +240,8 @@ idtoname_parse(struct cache_detail *cd, char *buf, in=
t buflen)
> 		goto out;
>=20
> 	/* expiry */
> -	ent.h.expiry_time =3D get_expiry(&buf);
> -	if (ent.h.expiry_time =3D=3D 0)
> +	error =3D get_expiry(&buf, &ent.h.expiry_time);
> +	if (error)
> 		goto out;
>=20
> 	error =3D -ENOMEM;
> @@ -408,8 +408,8 @@ nametoid_parse(struct cache_detail *cd, char *buf, in=
t buflen)
> 	memcpy(ent.name, buf1, sizeof(ent.name));
>=20
> 	/* expiry */
> -	ent.h.expiry_time =3D get_expiry(&buf);
> -	if (ent.h.expiry_time =3D=3D 0)
> +	error =3D get_expiry(&buf, &ent.h.expiry_time);
> +	if (error)
> 		goto out;
>=20
> 	/* ID */
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index ec5a555df96f..518bd28f5ab8 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -300,17 +300,18 @@ static inline int get_time(char **bpp, time64_t *ti=
me)
> 	return 0;
> }
>=20
> -static inline time64_t get_expiry(char **bpp)
> +static inline int get_expiry(char **bpp, time64_t *rvp)
> {
> -	time64_t rv;
> +	int error;
> 	struct timespec64 boot;
>=20
> -	if (get_time(bpp, &rv))
> -		return 0;
> -	if (rv < 0)
> -		return 0;
> +	error =3D get_time(bpp, rvp);
> +	if (error)
> +		return error;
> +
> 	getboottime64(&boot);
> -	return rv - boot.tv_sec;
> +	(*rvp) -=3D boot.tv_sec;
> +	return 0;
> }
>=20
> #endif /*  _LINUX_SUNRPC_CACHE_H_ */
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index acb822b23af1..bfaf584d296a 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -258,11 +258,11 @@ static int rsi_parse(struct cache_detail *cd,
>=20
> 	rsii.h.flags =3D 0;
> 	/* expiry */
> -	expiry =3D get_expiry(&mesg);
> -	status =3D -EINVAL;
> -	if (expiry =3D=3D 0)
> +	status =3D get_expiry(&mesg, &expiry);
> +	if (status)
> 		goto out;
>=20
> +	status =3D -EINVAL;
> 	/* major/minor */
> 	len =3D qword_get(&mesg, buf, mlen);
> 	if (len <=3D 0)
> @@ -484,11 +484,11 @@ static int rsc_parse(struct cache_detail *cd,
>=20
> 	rsci.h.flags =3D 0;
> 	/* expiry */
> -	expiry =3D get_expiry(&mesg);
> -	status =3D -EINVAL;
> -	if (expiry =3D=3D 0)
> +	status =3D get_expiry(&mesg, &expiry);
> +	if (status)
> 		goto out;
>=20
> +	status =3D -EINVAL;
> 	rscp =3D rsc_lookup(cd, &rsci);
> 	if (!rscp)
> 		goto out;
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index b1efc34db6ed..9e7798a69051 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -225,9 +225,9 @@ static int ip_map_parse(struct cache_detail *cd,
> 		return -EINVAL;
> 	}
>=20
> -	expiry =3D get_expiry(&mesg);
> -	if (expiry =3D=3D0)
> -		return -EINVAL;
> +	err =3D get_expiry(&mesg, &expiry);
> +	if (err)
> +		return err;
>=20
> 	/* domainname, or empty for NEGATIVE */
> 	len =3D qword_get(&mesg, buf, mlen);
> @@ -497,9 +497,9 @@ static int unix_gid_parse(struct cache_detail *cd,
> 	uid =3D make_kuid(current_user_ns(), id);
> 	ug.uid =3D uid;
>=20
> -	expiry =3D get_expiry(&mesg);
> -	if (expiry =3D=3D 0)
> -		return -EINVAL;
> +	err =3D get_expiry(&mesg, &expiry);
> +	if (err)
> +		return err;
>=20
> 	rv =3D get_int(&mesg, &gids);
> 	if (rv || gids < 0 || gids > 8192)
> --=20
> 2.39.2
>=20

--
Chuck Lever


