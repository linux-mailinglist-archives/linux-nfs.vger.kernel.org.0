Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D381568F2E
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiGFQ3p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiGFQ3p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:29:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4B21E24
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:29:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GOe7E010495;
        Wed, 6 Jul 2022 16:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yf3cxc7fqSoYM1q4cVxBc2ApOiYavDOGYYnqJ5Y4C0A=;
 b=V8GjlZycfNqyjUf8iddH8lj0gKVKaBZkefDBEPmPrCd459FnVOJXLTH3TfJL5mGZFgW/
 AmI3uE0OnVMgZTRiHpRS4w0xZstkoqCOmtj1/DBWDGD2YlbXSu2wgSiz3Ff5AiFKxQZU
 wbEI8X7pdhVt00Z0yR0Ot03+31/azG0PVM1QWir+WQFfS6897Ubo8xeJlxkc33Uxtdub
 2GmiR35i667ZDB43RQ2zQUY4jX+hJ/uGQDWM5LAqbO2B9AJB3aYT+3oh8Qj1F+Xs2OAy
 SK37WYHDi396ln9S7eIJLSLDm8Db1l1/N6ywdUqqxfxjpaFowW6+p8jSWzV11JADRYmP Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyafsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266GBSkn011152;
        Wed, 6 Jul 2022 16:29:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud86yuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INzl5rA9ihK/m9QMk2MV2rWb5795fvpRHV/+qybm+mYx6qt01HLpb5Qdo74Ms3rHP1lkDa7p9IF9WBM62ZVGybEmQwHXl4aYUB1En9q0TYca/qV3+bIKTkbfm+UD871HHdHWPRpNB07yqSw9hRlnxc1m6TiccuFluLFqKbX+KAh6Vcx4BuDQ2uUHf8FsuQRBA3tXK0SUIpuyNumhfDSbrQJbmgGnPFZ1BZc8NNW2G+0mcJKkJxFayirzuMcYuSnY6ifXmfANvAFGT5DqM2R1xcrSwK+0//cajhGZMEKH9fU9DzZtnO6+++arqCSBLZ+jGnn8JJhOEoIM8aN/CGuIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf3cxc7fqSoYM1q4cVxBc2ApOiYavDOGYYnqJ5Y4C0A=;
 b=ENIiDMc8To6n6QYw+EvemwM6PNPou3fDPvCfzipC0O/EUQnIQw+DVQhoWp5lZODias7e+Y40SJPs2cGzUEc+O+GuZrdkZreQfIIZTvQSfO8mmM7d+QtVQZT/V2CoFoGFgftF92gykCRTdY76jCALnCNi/vRhkilHoN10p55fRHoB/ogvPLu1lwroGNbQU7YDJxbP+utqFGNhbMfaDVhXKxbwSUVAjuw2rmjnp9FXPKapvIF8QoqyvNAlcD8AI4jAOsITssaVSk5q7Kj3EWFcn0zSel9VJ5KsCtFqn7TKTGJk0G6MjUBBRy6HCQqtTMg09c6ScOa3s1+bud4cSYDLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf3cxc7fqSoYM1q4cVxBc2ApOiYavDOGYYnqJ5Y4C0A=;
 b=ZvO0/wJXgVdlKTwISa1AshwWrzoaKSeheRN4b3PqxqmsbKuGvNgUmvQXux5iGiPwuHMkxusUb/HNo1DXex0u7xPfH71LDbjiNMPkQqr4A3Zo4Fqojnpn1Tm+qeCcJHd5vujCW6aUy8PxzsWEIR1LmSDleuh9gIrsq4OR3MMiJ9g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM8PR10MB5478.namprd10.prod.outlook.com (2603:10b6:8:33::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Wed, 6 Jul 2022 16:29:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:29:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] NFSD: only call fh_unlock() once in nfsd_link()
Thread-Topic: [PATCH 4/8] NFSD: only call fh_unlock() once in nfsd_link()
Thread-Index: AQHYkO/GCNr2yaRUtkmc1q0pviopdq1xiUGA
Date:   Wed, 6 Jul 2022 16:29:29 +0000
Message-ID: <956CFBD3-EAB7-461C-81CD-F0C4A4479807@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <165708109258.1940.6581517569232462503.stgit@noble.brown>
In-Reply-To: <165708109258.1940.6581517569232462503.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4548d363-5381-4544-fe20-08da5f6cb36a
x-ms-traffictypediagnostic: DM8PR10MB5478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HfuyUcQDYLu4huVctrwydpvjjw+Tx9VPsHzx2VgL3yXkterUIWDRcA+0a/j+qJ4Nae6rOWG1ZFBTIzj/VTlp5JvVhlzI+08WqxTVjuKQhp6119IR1AP7fR7OJuLkfIMX+MktsERRiSo05xqn9MGwaV7k6dh58VlZiX/MxyGUwrTgG1VEGysYd5rVX1pAaDO+VH+ePkkyJ79PBd0vAJa5lS9BgeBX9WsX1rw4tg9vEKYc5TR362RWKIsP6fsm+GQ1CWdDq5+bD/N7j8obACommszB9gKTXgpcwWL6z66osfn7SaARFqGdlWiDfoMWSU6Ye3dPjt353mKWTz15kvGYeNHT+6d0kcCt7OZbWK0feXytfgagsajCdvO9C+vsbU8oi8jyLZgmz6jfAEp6HTjA3LE3YKQlHw/bS24yZ1vQgJo9Fs61e195Kfy/xCd6B2V3faQdRwh+lSEPOIRWQX8s6wXWO8DAOFVUtJHU7YKH7aoFXY7Y/V4LkEfRGXryEp3sV+034zGX6WJIyjRd5MCR+9qA4QFpT3xivY7Mv/ACb496GArgPpUpq1i9lCbnHQAnYbltXHRTXJ1k67E6xH66hk0wpZPtLoDWQE8XvGIq+MtSNQ9XD6oaE9RYhkdQ78oQ5qzORKwHFjObpU+5tNCMPI08b7FPnFRFpzDDmWtEWkuc4qjz3TjZbCEfv9vg8rVpcqrQgkP/4No2miBR4RM6kki4yOBV5if/MrrmXO4NTB3GDB0pAIOfq62mKg+fDnQLsXQZUbuzcXg9Cdu711C5IK/HNCRlJ0RCE+dpitDq9rEI8kB6+fydSg6TcglqGlIdizJjnEgXk33btVAuxB20JkvHIWBHRXdmV3ps3Pr6WE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(136003)(346002)(6916009)(54906003)(38070700005)(122000001)(316002)(86362001)(8936002)(5660300002)(64756008)(83380400001)(4326008)(8676002)(66556008)(66946007)(76116006)(91956017)(26005)(6512007)(36756003)(2616005)(66446008)(6486002)(38100700002)(478600001)(2906002)(71200400001)(53546011)(41300700001)(33656002)(66476007)(6506007)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?inL7NYYdh/Afp+Fe84nfw7YSvf7B632MHfakrhX+1CFmI1Wk+zwPdbDmMB2S?=
 =?us-ascii?Q?Q2j2c7Y3UbLzEEMkJxlsTyGRQKiN4UmkTvnjqEblffLstJgbz/puQM80oaXd?=
 =?us-ascii?Q?H+SlKhOYQ1cStX8hH6q1/D0uqA2fecEkUBtW/rpoR8RDWto2EJxX5jkxTH0z?=
 =?us-ascii?Q?XnQruvaibeoKPAKdJ/2R+3HlGOUxzglV8djjCjhGLWNN5xpkjPSTVsS50ih3?=
 =?us-ascii?Q?W25t+KGh1psLxokAWTveYX4rSsaTVaXszjvIj4Ggjfzp0ju2vRtrXUPHxpvl?=
 =?us-ascii?Q?crn4Ogc0fKaRdKDGbgJ+Bo9l5FHeTo7nL76PzOvicOmo6k7hVTOSgde/YZi1?=
 =?us-ascii?Q?DZRxOV4Kid+0JKtEzgQnevmIrO8ubiRAxJAT2WuEOTULChAHc3KGLig8i6sU?=
 =?us-ascii?Q?x6zTXFOjD/LkTHKmrYqrZRchQyToMlr/TWJ/maFsw321Wkrykj6l3iGro1xj?=
 =?us-ascii?Q?oNVoNVNqGG7re+abemzve9tu736cQ4Ei8SclUnUtgA+2AsABhfWdX4t6sc6m?=
 =?us-ascii?Q?wIengaizbt2sKTwg3SfHdEA7WygAQVjiL/EcE6txAFWZFkMHbHff/2cXQFZL?=
 =?us-ascii?Q?fHFH4xkY82BVKVOZ9ZZaPKy6HjSA+14wU/4u1X07F16Gg0iK11OBXzy8qt43?=
 =?us-ascii?Q?kUxtemqKXAqdo+JTv3wbEMkc0/p/3DJLT+DHY4Egw8UJX4yjEMNRgc95mw0O?=
 =?us-ascii?Q?K0e1thqEEaaefmv8Io4YXQDMR93RIEe3nO6pKmGwYIrq8In5Dnpi35EvbuIs?=
 =?us-ascii?Q?IXpQCc5jN5ukNuqfJCaAnqMv0jAoaucjCzYQ7R3U4YtiVjZWo+/fxhS7deus?=
 =?us-ascii?Q?ZL9OXvttfjFouurIsRjmOPhwZNHJxfjoDLHt1lUlHLfIMJGnzU5KCpK1YCiu?=
 =?us-ascii?Q?sh65532cWAijEU/nNCxuu5wkxIq/+qD6Lw4/khwNRWsdOu4wUNPRg9lx2qXP?=
 =?us-ascii?Q?uUqA1YJ6aSAV6QXea44xHPxuf4OnvbJ5moOeDzLTiQLgPKbR0J0bS7O4so7O?=
 =?us-ascii?Q?6NnZyBkjQSCJgiBOT6FE0jOCYaxE7pJJOl1owwdahB7PslTEkRk2glg3yLJG?=
 =?us-ascii?Q?kBUnMY08eXLRKTFLZCJkDah5vTQYXiTycN/loKrW2P5fRSzwYQgCchAk5vaI?=
 =?us-ascii?Q?GtvCM1z7BN7yimdLt6oMiGcuN15d7rffEp78KBozMFxWvHqq//6565qOtVbS?=
 =?us-ascii?Q?UQ2sN70XPNPnynVPlUXrNjwCI4RQgB4fxK+J4sLr0HM5WidRrmEsjzq/EuSW?=
 =?us-ascii?Q?nYlW+LDDmgLN0sx8ebnBLtmim9Y+NSaE8dwNvuuYtz9PUiIpD/RFu5hp72Ju?=
 =?us-ascii?Q?9JQBHbv62lCKA912P7CIboU/J/5yHNRn1H87dyQGrEXzH1MqoYwkLjAXOR+I?=
 =?us-ascii?Q?m1cdN5Y30AStClAfV4r4lLLz9hetxnCPeVQ7E451U6cz4duPRbJV/YfoEDSG?=
 =?us-ascii?Q?vKFKBALcSKDUmzmIXLdkKszQx4rlkjipDvWnXI5YJXyRcX8mmuOqkJwHwvLa?=
 =?us-ascii?Q?hkpZskDCSNgzLiOMiPcHJ5qKpqqG1w3TVTtcOjKfPBzQZm1Dm0+LsSjFuFKF?=
 =?us-ascii?Q?vJhfvpnxF9Md9O3R9y0JXF4f3J4iPdKG8Z14vSx1yVBK0G1d4/Xa6DN12ufp?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB38F26DBFE4B347986CF71A802E0989@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4548d363-5381-4544-fe20-08da5f6cb36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:29:29.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozg/j7/FE/8EJsVWYB7uJcc4tXCzlAlHom3fUXjoFbwtpJpgJqc+9eWFwh3TzUko1IvzRRJC1YO04K6K5KfhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5478
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=737
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060065
X-Proofpoint-GUID: Ri6sOhVV1Gmv6lbBwnwd8OUCVWfifTzq
X-Proofpoint-ORIG-GUID: Ri6sOhVV1Gmv6lbBwnwd8OUCVWfifTzq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On non-error paths, nfsd_link() calls fh_unlock() twice.  This is safe
> because fh_unlock() records that the unlock has been done and doesn't
> repeat it.
> However it makes the code a little confusing and interferes with changes
> that are planned for directory locking.
>=20
> So rearrange the code to ensure fh_unlock() is called exactly once if
> fh_lock() was called.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/vfs.c |   18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 3f4579f5775c..4916c29af0fa 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1551,8 +1551,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
>=20
> 	dnew =3D lookup_one_len(name, ddir, len);
> 	host_err =3D PTR_ERR(dnew);
> -	if (IS_ERR(dnew))
> -		goto out_nfserr;
> +	if (IS_ERR(dnew)) {
> +		err =3D nfserrno(host_err);
> +		goto out_unlock;
> +	}

Nit: Let's do it this way:

	dnew =3D lookup_one_len(name, ddir, len);
	if (IS_ERR(dnew)) {
		err =3D nfserrno(PTR_ERR(dnew);
		goto out_unlock;
	}

> 	dold =3D tfhp->fh_dentry;
>=20
> @@ -1571,17 +1573,17 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> 		else
> 			err =3D nfserrno(host_err);
> 	}
> -out_dput:
> 	dput(dnew);
> -out_unlock:
> -	fh_unlock(ffhp);
> +out_drop_write:
> 	fh_drop_write(tfhp);
> out:
> 	return err;
>=20
> -out_nfserr:
> -	err =3D nfserrno(host_err);
> -	goto out_unlock;
> +out_dput:
> +	dput(dnew);
> +out_unlock:
> +	fh_unlock(ffhp);
> +	goto out_drop_write;
> }
>=20
> static void
>=20
>=20

--
Chuck Lever



