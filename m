Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893C610683
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 01:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiJ0XrI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiJ0XrH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 19:47:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE34437ED
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 16:47:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMOHKO030354;
        Thu, 27 Oct 2022 23:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jMFs06u+8znZWL/vqisDP04bw2Lzere4r+tFxCyaXIQ=;
 b=f3/c1HKufpD0F1sRDdHISxCCR0+BF1rhL7tg3Dj645DqwN35dhPX8yDdZHRr1dtARMn1
 XE7AKX6qNVYJAGuG/UI14K8nKYTlFLsP+ha5Bq731wIj52VN0SmFBE0Wf4nk8CDuEux9
 /S8Ki2j7TBWKo4eGTzL9rTBX2r0Cs2gSKan297+vl7oFJD6KVdvSUhKly4Ta4by0bOc0
 +G2tfX05bmvBuYSen3Yh4yg6TkL6/ZFblGKPVcEAOeR0mnylE8SRTEXPfpFaALi/cAsL
 mvwq2MVfOBrwZHAdJQEIYx3rEnl6hvz2wPHxXZ8+9HgGgQhnsT0SCaFYOcuod0/MF7KB aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahec0b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 23:47:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLOPja009543;
        Thu, 27 Oct 2022 23:47:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagfgp5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 23:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khLcKpdPpSyyLTRn2QhYgh68gMdL02WZtH9gmAGl9fqrWr+NCIprrNfhakRMAuVzi8re38AL3a+oRojdgpWuPhQ65HXLXUA0oC4mXA04YovHACB4y1aTr2RHZHQSGLhS+2SBt8Ir0AOuLQYQCqn6n34oYhq3g5QhPPU2nfj7As6CrVIEWrHbItKXrUoVeOKuFefjmshREMANHHB6WteM5pEynnp+Hnp/48ZSPij2NDxA/bg446Tz/OY9DF473a5PnacqeqibLshlRww2aoMv6njwtCMCVfwr+6nj03UyYxDLR/IHWdsqwiLhndDXghdanbCHHaemPqzk7KRIiilrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMFs06u+8znZWL/vqisDP04bw2Lzere4r+tFxCyaXIQ=;
 b=UO05Dl4tbXX2EPaAVfrJIU+aJA+xBQWKGr6h8hedNlMukBhz3LtZCpg4RoSc+oAXtYNBHWnI1fk+RT8PfqHnlJ/Gl0maHfxa3NCxrDRuDM/M4aCFQJYvbVw9Z3ycF3JxXTM1w7XG45/AwUQ3MeKA46sSYjLGrOf7+LDJqB58DMxtEtLmNy69ttbgC3huNJM10OluP9hJm6+HMJUiVzaZH7z+MkqBq+zQ7vHUZMTprI1/LVXyfMlUT5QgiQ4D/J0Qo/GZr9QVrYm8Q+L+bFQADc6rwFmAhJ+quH2rxDbtq4t7/hhgQsti1YWUmmgJmcPt756pVY+mhOVnxamHSh3AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMFs06u+8znZWL/vqisDP04bw2Lzere4r+tFxCyaXIQ=;
 b=kg1dZbBjTPQHuV6sOSsICkXBjyLZFqmEazebebsRibKSU5levDNqy8wZQnn59gf4Ref0BXSc2YDO17xC9QJHPaH5bcPzMjYF3J2VICFr2TsGO+yVIEjichZj0hJn7takIU1gEU836fq1K+n2hGtSsOuwgEbS1ZqeTIs0fvvlX2c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6114.namprd10.prod.outlook.com (2603:10b6:208:3b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 23:46:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 23:46:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v6 09/14] NFSD: Clean up nfsd4_init_file()
Thread-Topic: [PATCH v6 09/14] NFSD: Clean up nfsd4_init_file()
Thread-Index: AQHY6jVM9OOkZaAuPUqeFrTes3TrR64i4XuAgAAG6AA=
Date:   Thu, 27 Oct 2022 23:46:58 +0000
Message-ID: <293CDB70-F274-425C-BB16-9276BCC48545@oracle.com>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
 <166689675530.90991.2630847343462195612.stgit@klimt.1015granger.net>
 <166691293591.13915.198182531468244072@noble.neil.brown.name>
In-Reply-To: <166691293591.13915.198182531468244072@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6114:EE_
x-ms-office365-filtering-correlation-id: 89a2767d-eb11-43c0-6c9c-08dab87589cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1uKuXY5ZweQ3j+x47JnYUz3dbkuX7hxLiMWbh9CKlCPOabPGfbPCEQP+m4cZWsUI6+ed6aTDWbtlwWY4KWtH1H4qjROHWSSpOLn3+WMpORgV984+8tEYf02n49auawBZAlCfrqjdF83wqf+07rkkt+mbwsmtG39JsoFlSUzbf3SUqkA0NbU8GnXxlFtD2/7eTSTsyTq7ZVVhfCuRLVDhuTmDIG1Am4T+XGkisKcZlGq6drH1J0mLepNQBe/f3JMo1buqdOd5MjJr9CsnPK4KlRVb0Pv1LT+pJtsCvU38vr2xDz7Bhi2mPgx6qDuM7Cj58DKvdwFGvsKspWD3iZ/P+4hp5BYVcv08upNHnyVBAIhYbrU3w8ayxTM86qY31GG+UzIaA3QcSHBYcS1t93ncnwUmq2mKymh7jpxQgnE9cJOVCsEZm3LGK82P5aljgfQeN/CRmrR/EQt/HqJWNcQGmEbCmTHUccO/h6BuCzDUBDL/2XJVKsAL4EiIAQbIV3W/lGbyJaMCXw+Z2l+D0D5POg8nCwYUTRp3FzuInWEPbvEhuAn9s2uF2qH4uLId8hJ2jF1zAUVh3phk/Qstx+HFXOnyoQ6O7QICi+5KRTBhFfucpBaz0rriVV1BcleTBr936hH2yItebQTf7fwZvCQB+uG113G5L99SvDT9GE0MvQSvMt8fLEtgg0DSa05HMz7cj65oRS3yl/9e24PWNwYwGrueS3O3rQAH1KFCjPzj07kVuNjuWPg2wWdF+91zeY1e85TaZgEq728ivE4Xqm1PfU/60iw3YTRFqe/cbyRqFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(5660300002)(186003)(38070700005)(2616005)(86362001)(2906002)(122000001)(53546011)(8936002)(41300700001)(4744005)(76116006)(91956017)(71200400001)(316002)(6512007)(66556008)(66946007)(26005)(66476007)(6506007)(4326008)(6486002)(64756008)(6916009)(478600001)(66446008)(38100700002)(8676002)(54906003)(33656002)(36756003)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvkcsMO7G743IDRbIf73fhTb84TPaybl7xjzX3OFSjy43CRed/nlikOOub+m?=
 =?us-ascii?Q?IVWoTgaSUwlytrUdaELMQ9lSRLU3gll6O5ofAVDcGVQxyHudkN5nMBpvjaP6?=
 =?us-ascii?Q?83QStXheuhIdenWyiX6EMGZB++CMlFiW+6ut11x61jZfGxwYI+J4+msHIHPC?=
 =?us-ascii?Q?vjfWmkV8hJzmdo6PUZ9ZS3MBUaiFUGUedUrUIsjxA+OdY5tO3XjReI2CzOfQ?=
 =?us-ascii?Q?psyNgLj5cqQHA3PKzqKv5MfMkG+v0v1SK9oz4OGMXIOyEvka5Z4JaXo2WYpb?=
 =?us-ascii?Q?l6GdN2apnSVIkgSqtHALAQYfDtAeEkIJFWqSQSdGxeZh/T8Lw7LbboohmXjS?=
 =?us-ascii?Q?bRtla6BAW7/VshBiYGPmcIC8OK/QgLR9Pfg+1mwtd59nZ5ejDtoRlsbFLgCB?=
 =?us-ascii?Q?NFL5TPCN1bE+KWbn/ltFK0Yz0JgqbWwUpl41lIy1K4ihkqtoHzu+OiimExai?=
 =?us-ascii?Q?uloM/eD8+1h7gNxoJ3XIRTrSrOB27TSXkJCFYDnwnreoBWXFVEfejrgZFYXg?=
 =?us-ascii?Q?CYZO7ltim22GE0lQOO6aCO4F39o5fxctB02z2rlsFeXOP312uTRpNV5PiTOj?=
 =?us-ascii?Q?EYkCk5rvFnkgbiVZr+up2jFCrqPSL4AOylG7EOvEPS16pQJSnTVv4B8gy7rR?=
 =?us-ascii?Q?zVcHbkHzKcD7FQQOW7dtz3zlhw90XMkR14qy0Pqxu6YY4hNlYwp/NK4YnKF/?=
 =?us-ascii?Q?mQgPyHw/RN5ffPjwNdcvD8ewJlsWO1QaB2+HN4ygY6BI/L6JOkOeN0YmM5VO?=
 =?us-ascii?Q?zmaCF8pYEKiXBdPzc3apOYapfk8vGrHWLITWJe/HQ50g0V7rhpjYJTDnzDRe?=
 =?us-ascii?Q?1U46149jnahgM1kRqBpryfU7zO/P/w53uTAzFwE2y3SVsRbCbMhIR/sSezpO?=
 =?us-ascii?Q?vR/9BM8n8yhooetNS7Z4Tezz0ppxgWrbf/GS5XwH/iAPnhV4Gl0i4dGHXLCt?=
 =?us-ascii?Q?OFr2nGwrgc36zrrUqeBQ76dqLcIr/lbnRDgGvDJ2huN4v5TQH1azN/FjOrE/?=
 =?us-ascii?Q?vaPAdqyipAnkLpoLPcNtpuPB2NBlrSQll2YWwJc28MDQFKn7uMEQ863qrP0u?=
 =?us-ascii?Q?lhlvb7pK9z7FYjA3OauEqOYgB+8HOVjBkdsQbQR24YrshSgJ8BcTsKhrcgck?=
 =?us-ascii?Q?IPZAs13N+1XuYkPxY8JkJQ615CoLBVYSQFprbL3sP9GwJ28m14pI0KDXxArK?=
 =?us-ascii?Q?1kXvV+piv+Lx5P4uA2lOxQpkVG3akrzYkjC0erh6W+eDr1kza9rZan9oSHUF?=
 =?us-ascii?Q?nS4Y528JD/gLiDtNMMAuLyh1TZfS9IIVRcVc67R67/3cRatQRT6lLeMf/1jn?=
 =?us-ascii?Q?VGxjvd3u/EkYZb1AvsUQxgSrNpoqDmkC92qw/FTcPCuGyIiPHbBgdSdQzKsV?=
 =?us-ascii?Q?V+ty+skFh4BFPG4ojkuxKGcEPOmZGzqP/eWbI4m0pJaD8/XdNn7k+yx+3qET?=
 =?us-ascii?Q?jKxKWagrSNda5msLwcIdqsl0sAAdRTJjjnQxJMtBTu4FaQKNOPVIrg52YIuV?=
 =?us-ascii?Q?OF8I0l6RauHPXVPQ4GG9y1njKwEwP5+87Fd8EuDgSn59wfiXmQ6LALgeKDcY?=
 =?us-ascii?Q?W1f3kZmSKpPuxD6OwqJTwf3KG0oV0OXo0Ar3sWetmS7C1BUS22wKnYFkDoOo?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14B14E55EF948149A5F3B504D8BD7E60@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a2767d-eb11-43c0-6c9c-08dab87589cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 23:46:58.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAfCDntSU5IeZITSVDmPS+KYBH3VhwovvldBLn9EugNtimhhcQwGiGdXqi4ZigWifnBjCAArHras3qUw37D/QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270135
X-Proofpoint-GUID: XL9bRwt-XQI8C3vKnE3VkW6wG3cPyLQw
X-Proofpoint-ORIG-GUID: XL9bRwt-XQI8C3vKnE3VkW6wG3cPyLQw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2022, at 7:22 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 28 Oct 2022, Chuck Lever wrote:
>> Name nfs4_file-related helpers consistently. There are already
>> nfs4_file_yada functions, so let's go with the same convention used
>> by put_nfs4_file(): init_nfs4_file().
>=20
> I don't understand.  You say "consistently", then you say that as we
> have lots of "nfs4_file_yada" functions, this new one will NOT follow
> that pattern.

Patch description is admittedly terse.

I want a naming convention that sets apart the helpers that
deal with the nfs4_file hash table. Maybe nfs4_file_hash_yada
would be a better choice?

But we already have put_nfs4_file()...


> Surely "consistency" means renaming put_nfs4_file() to nfs4_file_put(),
> and introducing nfs4_file_init().
>=20
> Not that I really care that much about the naming, but would like to be
> able to follow your logic.
>=20
> Thanks,
> NeilBrown

--
Chuck Lever



